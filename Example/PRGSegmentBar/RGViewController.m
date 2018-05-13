//
//  RGViewController.m
//  PRGSegmentBar
//
//  Created by rookiePRG on 05/14/2018.
//  Copyright (c) 2018 rookiePRG. All rights reserved.
//

#import "RGViewController.h"
#import "PRGSegmentBarVC.h"

@interface RGViewController ()
@property (nonatomic, strong) PRGSegmentBarVC *segmentBarVC;

@end

@implementation RGViewController

-(PRGSegmentBarVC *)segmentBarVC
{
    if (!_segmentBarVC) {
        PRGSegmentBarVC *vc = [[PRGSegmentBarVC alloc] init];
        [self addChildViewController:vc];
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.segmentBarVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentBarVC.view];
    
    NSArray *items = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8"];
    
    // 添加几个自控制器
    // 在contentView, 展示子控制器的视图内容
    
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *vc4 = [UIViewController new];
    vc4.view.backgroundColor = [UIColor blackColor];
    
    UIViewController *vc5 = [UIViewController new];
    vc5.view.backgroundColor = [UIColor grayColor];
    
    UIViewController *vc6 = [UIViewController new];
    vc6.view.backgroundColor = [UIColor purpleColor];
    
    UIViewController *vc7 = [UIViewController new];
    vc7.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc8 = [UIViewController new];
    vc8.view.backgroundColor = [UIColor blueColor];
    
    
    [self.segmentBarVC setupWithItems:items childVCs:@[vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8]];
    
    [self.segmentBarVC.segmentBar updateViewWithConfig:^(PRGSegmentBarConfig *config) {
        config.itemNormalColor = [UIColor blueColor];
        config.itemSelectColor = [UIColor purpleColor];
        config.lineColor = [UIColor greenColor];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
