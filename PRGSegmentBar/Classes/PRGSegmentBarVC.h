//
//  PRGSegmentBarVC.h
//
//  Created by belief on 2018/5/13.
//  Copyright © 2018年 rookiePRG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRGSegmentBar.h"
@interface PRGSegmentBarVC : UIViewController

@property (nonatomic, weak) PRGSegmentBar *segmentBar;

/**
 设置数据
 @param items 标题集合
 @param childVCs 子控制器集合
 */
-(void)setupWithItems:(NSArray <NSString *>*)items childVCs:(NSArray<UIViewController *>*)childVCs;

@end
