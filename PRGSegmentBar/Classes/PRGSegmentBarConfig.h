//
//  PRGSegmentBarConfig.h
//
//  Created by belief on 2018/5/13.
//  Copyright © 2018年 rookiePRG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRGSegmentBarConfig : NSObject

+(instancetype)defaultConfig;

/**
 背景色
 */
@property (nonatomic, strong) UIColor *segmentBarBackColor;
/**
 按钮默认颜色
 */
@property (nonatomic, strong) UIColor *itemNormalColor;
/**
 按钮选中颜色
 */
@property (nonatomic, strong) UIColor *itemSelectColor;
/**
 按钮字体大小
 */
@property (nonatomic, strong) UIFont *itemFont;
/**
 滑动条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;
/**
 滑动条高度
 */
@property (nonatomic, assign) CGFloat lineHeight;
/**
 滑动条超出宽度
 */
@property (nonatomic, assign) CGFloat lineExtraW;

//链式编程写法
//@property (nonatomic, copy, readonly) PRGSegmentBarConfig *(^segmentBarBC)(UIColor *color);
//@property (nonatomic, copy, readonly) PRGSegmentBarConfig *(^itemNC)(UIColor *color);
//@property (nonatomic, copy, readonly) PRGSegmentBarConfig *(^itemSC)(UIColor *color);
//@property (nonatomic, copy, readonly) PRGSegmentBarConfig *(^itemF)(UIFont *font);
//@property (nonatomic, copy, readonly) PRGSegmentBarConfig *(^lineC)(UIColor *color);
//@property (nonatomic, copy, readonly) PRGSegmentBarConfig *(^lineH)(CGFloat h);
//@property (nonatomic, copy, readonly) PRGSegmentBarConfig *(^lineEW)(CGFloat ew);

@end
