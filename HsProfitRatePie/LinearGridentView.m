//
//  LinearGridentView.m
//  HsProfitRatePie
//
//  Created by HuiYin on 15/7/3.
//  Copyright (c) 2015年 SnailGame. All rights reserved.
//

#import "LinearGridentView.h"

@implementation LinearGridentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//线性渐变
- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    //颜色的分量表示

    CGFloat components[] = {1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0};

    //颜色的位置

    CGFloat locations[] = {1.0, 0.0, 0.5};

    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);

    //渐变的区域是当前context，垂直于startPoint <-> endPoint线段，并且于这条线段相交的直线
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(100, 0), CGPointMake(200, 0), 0);
    
    CGFloat locations2[] = {0.4, 1.0};
    
    CGGradientRef gradient2 = CGGradientCreateWithColorComponents(colorSpace, components, locations2, 2);
    
    //渐变的区域是当前context，垂直于startPoint <-> endPoint线段，并且于这条线段相交的直线
    
    CGContextDrawLinearGradient(context, gradient2, CGPointMake(210, 0), CGPointMake(310, 0), 0);
    
}

@end
