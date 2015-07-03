//
//  GridentView.m
//  HsProfitRatePie
//
//  Created by HuiYin on 15/7/3.
//  Copyright (c) 2015年 SnailGame. All rights reserved.
//

#import "GridentView.h"

@implementation GridentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//环状渐变

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    NSArray *array = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor purpleColor].CGColor];
        
        CGFloat locations[] = {0.0, 0.5, 1.0};
        
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)array, locations);
        
        CGContextDrawRadialGradient(context, gradient, CGPointMake(200, 200), 0, CGPointMake(150, 200), 100, 0);
        
}
@end
