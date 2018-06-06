//
//  PRGSegmentBar.m
//
//  Created by belief on 2018/5/13.
//  Copyright © 2018年 rookiePRG. All rights reserved.
//

#import "PRGSegmentBar.h"
#import "UIView+RGLayout.h"

#define kMinMargin 10

@interface PRGSegmentBar ()
{
    //最后一次点击的btn
    UIButton *_lastBtn;
}

/**
 视图
 */
@property (nonatomic, weak) UIScrollView *contentView;
/**
 存放按钮的集合
 */
@property (nonatomic, strong) NSMutableArray <UIButton *> *itemBtns;

/**
 底部滑动条
 */
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) PRGSegmentBarConfig *segmentBarConfig;

@end

@implementation PRGSegmentBar

+(instancetype)segmentbarWithConfig:(PRGSegmentBarConfig *)config
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect defaultFrame = CGRectMake(0, 0, width, 40);
    PRGSegmentBar *segmentBar = [[PRGSegmentBar alloc] initWithFrame:defaultFrame];
    segmentBar.segmentBarConfig = config;
    return segmentBar;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.segmentBarConfig = [PRGSegmentBarConfig defaultConfig];
    }
    return self;
}

-(void)updateViewWithConfig:(void (^)(PRGSegmentBarConfig *))configBlock
{
    PRGSegmentBarConfig *config = [[PRGSegmentBarConfig alloc] init];
    
    if (configBlock) {
        configBlock(config);
    }
    self.segmentBarConfig = config;
    
}


#pragma mark -lazy
-(NSMutableArray<UIButton *> *)itemBtns
{
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

-(UIView *)lineView
{
    if (!_lineView) {
        CGFloat lineViewH = self.segmentBarConfig.lineHeight;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-lineViewH, 0, lineViewH)];
        lineView.backgroundColor = self.segmentBarConfig.lineColor;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

-(UIScrollView *)contentView
{
    if (!_contentView) {
        
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.bounces = NO;
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}


#pragma mark -setter

-(void)setSegmentBarConfig:(PRGSegmentBarConfig *)segmentBarConfig
{
    _segmentBarConfig = segmentBarConfig;
    self.backgroundColor = segmentBarConfig.segmentBarBackColor;
    self.lineView.height = segmentBarConfig.lineHeight;
    self.lineView.backgroundColor = segmentBarConfig.lineColor;
    
    // 选项颜色/字体
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:segmentBarConfig.itemNormalColor forState:UIControlStateNormal];
        btn.titleLabel.font = segmentBarConfig.itemFont;
        [btn setTitleColor:segmentBarConfig.itemSelectColor forState:UIControlStateSelected];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    if (selectIndex < 0 || selectIndex >self.itemBtns.count -1 || self.itemBtns.count == 0) {
        return;
    }
    _selectIndex = selectIndex;
    UIButton *btn = self.itemBtns[selectIndex];
    [self btnClick:btn];
}

-(void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    
    //删除之前添加的控件
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    //根据items 创建button添加到视图中
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn setTitle:item forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    //刷新布局
    [self setNeedsLayout]; //标识， 刷新标识
    [self layoutIfNeeded]; //立即刷新
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    NSLog(@"%f",self.bounds.size.width);
    
    //计算margin
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    
    CGFloat calculateMargin = (self.width - totalBtnWidth) / (self.itemBtns.count + 1);
    if (calculateMargin < kMinMargin) {
        calculateMargin = kMinMargin;
    }
    
    CGFloat lastX = calculateMargin;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        btn.y = 0;
        btn.x = lastX;
        lastX += btn.width + calculateMargin;
    }
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    if (self.itemBtns.count == 0) {
        return;
    }
    
    UIButton *btn = self.itemBtns[self.selectIndex];
    self.lineView.width = btn.width + self.segmentBarConfig.lineExtraW * 2;
    self.lineView.centerX = btn.centerX;
    self.lineView.height = self.segmentBarConfig.lineHeight;
    self.lineView.y = self.height - self.lineView.height;
}

#pragma mark - 点击事件
-(void)btnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentBarDidSelectIndex:fromIndex:)]) {
        [self.delegate segmentBarDidSelectIndex:sender.tag fromIndex:_lastBtn.tag];
    }
    
    _selectIndex = sender.tag;
    _lastBtn.selected = NO;
    sender.selected = YES;
    _lastBtn = sender;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.lineView.width = sender.width;
        self.lineView.centerX = sender.centerX;
    }];
    
    //scrollView滚动到btn的位置
    /*
        让选中的btn显示在中间，那么scrollView的contentOffset.x就等于btn的centerX -scrollView.width * 0.5
        scrollView的contentOffset.X 最小就是0
        scrollView的contentOffset.X 最大就是scrollView.contentSize.width - scrollView.width
     
     */
    CGFloat scrollX = sender.centerX - self.contentView.width * 0.5;
    
    if (scrollX < 0) {
        scrollX = 0;
    }
    
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}

@end
