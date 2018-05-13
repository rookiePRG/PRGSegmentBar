//
//  PRGSegmentBar.h
//
//  Created by belief on 2018/5/13.
//  Copyright © 2018年 rookiePRG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRGSegmentBarConfig.h"

@protocol PRGSegmentBarDelegate<NSObject>

/**
 代理方法
 @param toIndex 选中的索引
 @param fromIndex 上一个索引
 */
-(void)segmentBarDidSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end

@interface PRGSegmentBar : UIView

/**
 快速创建
 */
+(instancetype)segmentbarWithConfig:(PRGSegmentBarConfig *)config;
/**
 代理
 */
@property (nonatomic, weak) id<PRGSegmentBarDelegate>delegate;
/**
 标题的集合
 */
@property (nonatomic, strong) NSArray <NSString *> *items;
/**
 当前选中的索引
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 根据配置，更新视图
 */
- (void)updateViewWithConfig: (void(^)(PRGSegmentBarConfig *config))configBlock;

@end
