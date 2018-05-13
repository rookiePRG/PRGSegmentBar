//
//  PRGSegmentBarVC.m
//
//  Created by belief on 2018/5/13.
//  Copyright © 2018年 rookiePRG. All rights reserved.
//

#import "PRGSegmentBarVC.h"

#import "UIView+RGLayout.h"
#import "PRGSegmentBarConfig.h"


@interface PRGSegmentBarVC ()<PRGSegmentBarDelegate, UIScrollViewDelegate>


@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation PRGSegmentBarVC

#pragma mark -lazy
-(PRGSegmentBar *)segmentBar
{
    if (!_segmentBar) {
        PRGSegmentBar *segmentBar = [PRGSegmentBar segmentbarWithConfig:[PRGSegmentBarConfig defaultConfig]];
        segmentBar.delegate = self;
        segmentBar.backgroundColor = [UIColor grayColor];
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    return  _segmentBar;
}

-(UIScrollView *)contentView
{
    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        contentView.bounces = NO;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return  _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)setupWithItems:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs
{
    NSAssert(items.count != 0 || items.count == childVCs.count, @"数据存在问题");
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    self.segmentBar.items = items;
    
    //添加控制器
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    
    self.contentView.contentSize = CGSizeMake(items.count * self.view.width, 0);
    self.segmentBar.selectIndex = 0;
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (self.segmentBar.superview == self.view) {
        self.segmentBar.frame = CGRectMake(0, 60, self.view.width, 35);
        
        CGFloat contentViewY = self.segmentBar.y + self.segmentBar.height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height - contentViewY);
        self.contentView.frame = contentFrame;
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
        
        return;
    }
    
    CGRect contentFrame = CGRectMake(0, 0,self.view.width,self.view.height);
    self.contentView.frame = contentFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
}


#pragma mark -代理
-(void)segmentBarDidSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    [self showChildVCViewsAtIndex:toIndex];
}

//减速完成，滚动将停止，一次滚动只会调用一次
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = self.contentView.contentOffset.x/self.contentView.width;
    self.segmentBar.selectIndex = index;
}

- (void)showChildVCViewsAtIndex: (NSInteger)index {
    
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:vc.view];
    
    // 滚动到对应的位置
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.width, 0) animated:NO];
    
    
}

@end
