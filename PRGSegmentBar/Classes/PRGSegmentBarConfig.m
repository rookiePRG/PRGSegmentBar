//
//  PRGSegmentBarConfig.m
//
//  Created by belief on 2018/5/13.
//  Copyright © 2018年 rookiePRG. All rights reserved.
//

#import "PRGSegmentBarConfig.h"

@implementation PRGSegmentBarConfig

+ (instancetype)defaultConfig {
    
    PRGSegmentBarConfig *config = [[PRGSegmentBarConfig alloc] init];
    return config;
    
}

-(UIColor *)segmentBarBackColor
{
    if (!_segmentBarBackColor) {
        _segmentBarBackColor = [UIColor clearColor];
    }
    return _segmentBarBackColor;
}

-(UIColor *)itemNormalColor
{
    if (!_itemNormalColor) {
        _itemNormalColor = [UIColor lightGrayColor];
    }
    return _itemNormalColor;
}

-(UIColor *)itemSelectColor
{
    if (!_itemSelectColor) {
        _itemSelectColor = [UIColor redColor];
    }
    return _itemSelectColor;
}

-(UIFont *)itemFont
{
    if (!_itemFont) {
        _itemFont = [UIFont systemFontOfSize:15];
    }
    return _itemFont;
}

-(UIColor *)lineColor
{
    if (!_lineColor) {
        _lineColor = [UIColor redColor];
    }
    return _lineColor;
}

-(CGFloat)lineHeight
{
    if (_lineHeight<=0) {
        _lineHeight = 2.0;
    }
    return _lineHeight;
}

-(CGFloat)lineExtraW
{
    if (_lineExtraW<=0) {
        _lineExtraW = 10;
    }
    return _lineExtraW;
}

@end
