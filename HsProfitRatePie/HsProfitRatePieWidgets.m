//
//  HsProfitRatePieWidgets.m
//  HsProfitRatePie
//
//  Created by snailgame on 15/7/2.
//  Copyright (c) 2015年 SnailGame. All rights reserved.
//

#import "HsProfitRatePieWidgets.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation HsProfitRatePieWidgets

+ (void)initialize {
  if (self == [HsProfitRatePieWidgets class]) {
    id appearance = [self appearance];

    [appearance setShowText:YES];  //用来控制是否显示显示label
    [appearance setRoundedHead:YES];  //用来控制是否对进度两边进行处理
    [appearance setShowShadow:NO];  //控制圆环进度条的样式

    [appearance setThicknessRatio:0.07f];  //圆环进度条的宽度

    [appearance setInnerBackgroundColor:nil];
    [appearance setOuterBackgroundColor:nil];

    [appearance
        setProgressTopGradientColor:[UIColor greenColor]];  //进度条前半部分颜色
    [appearance setProgressBottomGradientColor:
                    [UIColor redColor]];  //进度条后半部分颜色
    [appearance setBackgroundColor:[UIColor clearColor]];
  }
}

- (id)init {
  //  self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
  self.unit = @"";
  return self;
}

- (NSString *)getNameByUnit:(NSString *)unit {
  if ([unit isEqualToString:@"分"]) {
    return @"语音";
  }

  return @"";
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  // Calculate position of the circle
  CGFloat progressAngle = -_progress * 360.0 - 90;
  CGPoint center = CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
  CGFloat radius = MIN(rect.size.width, rect.size.height) / 2.0f - 20;

  CGRect square;
  if (rect.size.width > rect.size.height) {
    square = CGRectMake((rect.size.width - rect.size.height) / 2.0, 0.0,
                        rect.size.height, rect.size.height);
  } else {
    square = CGRectMake(0.0, (rect.size.height - rect.size.width) / 2.0,
                        rect.size.width, rect.size.width);
  }

  //进度条宽度
  CGFloat circleWidth = radius * _thicknessRatio;
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);

  if (_innerBackgroundColor) {
    //内环
    // Fill innerCircle with innerBackgroundColor
    UIBezierPath *innerCircle =
        [UIBezierPath bezierPathWithArcCenter:center
                                       radius:radius - circleWidth
                                   startAngle:2 * M_PI
                                     endAngle:0.0
                                    clockwise:YES];

    [_innerBackgroundColor setFill];

    [innerCircle fill];
  }

  if (_outerBackgroundColor) {
    //外环
    // Fill outerCircle with outerBackgroundColor
    UIBezierPath *outerCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:radius
                                                           startAngle:0.0
                                                             endAngle:2 * M_PI
                                                            clockwise:NO];
    [outerCircle addArcWithCenter:center
                           radius:radius - circleWidth
                       startAngle:2 * M_PI
                         endAngle:0.0
                        clockwise:YES];

    [_outerBackgroundColor setFill];

    [outerCircle fill];
  }

  if (_showShadow) {
    //圆环背景处理
    CGFloat locations[5] = {0.0f, 0.33f, 0.66f, 1.0f};

    NSArray *gradientColors = @[
      (id)[[UIColor clearColor] CGColor],
      (id)[[UIColor clearColor] CGColor],
      (id)[[UIColor clearColor] CGColor],
      (id)[[UIColor clearColor] CGColor],
    ];

    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(
        rgb, (__bridge CFArrayRef)gradientColors, locations);
    CGContextDrawRadialGradient(context, gradient, center, radius - circleWidth,
                                center, radius, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(rgb);
  }

  if (_showText) {
    if (!_progress) {
      return;
    }
    if ([self viewWithTag:5]) {
      [_textLabel removeFromSuperview];
    }

    if ([self viewWithTag:6]) {
      [_bgImageView removeFromSuperview];
    }

    if ([self viewWithTag:7]) {
      [_descLabel removeFromSuperview];
    }

    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.frame = CGRectMake(square.origin.x, square.origin.y,
                                    square.size.width, square.size.height);
    _bgImageView.image = [UIImage imageNamed:@"liuliang"];
    _bgImageView.tag = 6;
    [self addSubview:_bgImageView];

    //中间显示label
    _textLabel = [[UILabel alloc] init];
    //字符串处理
    NSString *str = [NSString stringWithFormat:@"%.f %@", _progress * 100.0,
                                               self.unit];  //[NSString
    // stringWithFormat:@"%0.2f",
    //_progress * 100.0];

    NSMutableAttributedString *progressStr =
        [[NSMutableAttributedString alloc] initWithString:str];
    [progressStr
        addAttribute:NSFontAttributeName
               value:[UIFont fontWithName:@"Helvetica-LightOblique" size:70]
               range:NSMakeRange(0, str.length - 1)];
    [progressStr
        addAttribute:NSFontAttributeName
               value:[UIFont fontWithName:@"Helvetica-LightOblique" size:20]
               range:NSMakeRange(str.length - 1, 1)];
    _textLabel.attributedText = progressStr;
    _textLabel.numberOfLines = 0;
    _textLabel.bounds = CGRectMake(0, 0, 200, 200);
    _textLabel.textColor = [UIColor orangeColor];
    _textLabel.center = CGPointMake(self.bounds.size.width / 2.0,
                                    self.bounds.size.height / 2.0);

    _textLabel.tag = 5;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel];

    _descLabel = [[UILabel alloc] init];
    _descLabel.text =
        [NSString stringWithFormat:@"剩余%@", [self getNameByUnit:self.unit]];
    _descLabel.frame = CGRectMake(0, 0, 100, 50);
    _descLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.textColor = [UIColor orangeColor];
    _descLabel.center =
        CGPointMake(_textLabel.center.x, _textLabel.center.y - 55);
    _descLabel.tag = 7;
    [self addSubview:_descLabel];
  }

  UIBezierPath *path = [UIBezierPath bezierPath];

  [path appendPath:[UIBezierPath
                       bezierPathWithArcCenter:center
                                        radius:radius
                                    startAngle:DEGREES_TO_RADIANS(-90)
                                      endAngle:DEGREES_TO_RADIANS(progressAngle)
                                     clockwise:NO]];
  NSLog(@"progressAngle: %f", progressAngle);

    CGPoint endPoint;
  if (_roundedHead) {
    //终点处理
    
    endPoint.x =
        (cos(DEGREES_TO_RADIANS(progressAngle)) * (radius - circleWidth / 2)) +
        center.x;
    endPoint.y =
        (sin(DEGREES_TO_RADIANS(progressAngle)) * (radius - circleWidth / 2)) +
        center.y;

    //    [path addArcWithCenter:point
    //                    radius:circleWidth / 2
    //                startAngle:DEGREES_TO_RADIANS(progressAngle)
    //                  endAngle:DEGREES_TO_RADIANS(270.0 + progressAngle -
    //                  90.0)
    //                 clockwise:YES];

    [path addArcWithCenter:endPoint
                    radius:4
                startAngle:0
                  endAngle:360
                 clockwise:YES];
  }

  [path addArcWithCenter:center
                  radius:radius - circleWidth
              startAngle:DEGREES_TO_RADIANS(progressAngle)
                endAngle:DEGREES_TO_RADIANS(-90)
               clockwise:YES];
  //起始点添加分割线
  //  UIView *lineView =
  //      [[UIView alloc] initWithFrame:CGRectMake(radius, 0, 1, circleWidth)];
  //  lineView.backgroundColor = [UIColor whiteColor];
  //  [self addSubview:lineView];

  if (_roundedHead) {
    //起始点处理
    //    CGPoint point;
    //    point.x =
    //        (cos(DEGREES_TO_RADIANS(-90)) * (radius - circleWidth / 2)) +
    //        center.x;
    //    point.y =
    //        (sin(DEGREES_TO_RADIANS(-90)) * (radius - circleWidth / 2)) +
    //        center.y;
    //
    //    [path addArcWithCenter:point
    //                    radius:circleWidth / 2
    //                startAngle:DEGREES_TO_RADIANS(90)
    //                  endAngle:DEGREES_TO_RADIANS(-90)
    //                 clockwise:NO];
  }

  [path closePath];
  //进度条颜色处理
  if (_progressFillColor) {
    [_progressFillColor setFill];
    [path fill];
  } else if (_progressTopGradientColor && _progressBottomGradientColor) {
    [path addClip];

    NSArray *backgroundColors = @[
      (id)[_progressTopGradientColor CGColor],
      (id)[_progressBottomGradientColor CGColor],
    ];
    CGFloat backgroudColorLocations[2] = {0.0f, 1.0f};
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGGradientRef backgroundGradient = CGGradientCreateWithColors(
        rgb, (__bridge CFArrayRef)(backgroundColors), backgroudColorLocations);
//    CGContextDrawLinearGradient(context, backgroundGradient,
//                                CGPointMake(square.origin.x, square.origin.y),
//                                CGPointMake(square.origin.x + square.size.width, square.size.height), 0);
      
//      CGContextDrawRadialGradient(context, backgroundGradient, center, 0, endPoint, radius - circleWidth*0.5, 0);
    CGGradientRelease(backgroundGradient);
    CGColorSpaceRelease(rgb);
  }

  CGContextRestoreGState(context);
}

#pragma mark - Setter
//设置进度
- (void)setProgress:(double)progress {
  _progress = MIN(1.0, MAX(0.0, progress));

  [self setNeedsDisplay];
}

#pragma mark - UIAppearance

- (void)setShowText:(NSInteger)showText {
  _showText = showText;

  [self setNeedsDisplay];
}

- (void)setRoundedHead:(NSInteger)roundedHead {
  _roundedHead = roundedHead;

  [self setNeedsDisplay];
}

- (void)setShowShadow:(NSInteger)showShadow {
  _showShadow = showShadow;

  [self setNeedsDisplay];
}
//进度条宽度与半径之比
- (void)setThicknessRatio:(CGFloat)thickness {
  _thicknessRatio = MIN(MAX(0.0f, thickness), 1.0f);

  [self setNeedsDisplay];
}
//内环
- (void)setInnerBackgroundColor:(UIColor *)innerBackgroundColor {
  _innerBackgroundColor = innerBackgroundColor;

  [self setNeedsDisplay];
}
//外环
- (void)setOuterBackgroundColor:(UIColor *)outerBackgroundColor {
  _outerBackgroundColor = outerBackgroundColor;

  [self setNeedsDisplay];
}
//进度条颜色
- (void)setProgressFillColor:(UIColor *)progressFillColor {
  _progressFillColor = progressFillColor;

  [self setNeedsDisplay];
}
//进度条前半部分颜色
- (void)setProgressTopGradientColor:(UIColor *)progressTopGradientColor {
  _progressTopGradientColor = progressTopGradientColor;

  [self setNeedsDisplay];
}
//进度条后半部分颜色
- (void)setProgressBottomGradientColor:(UIColor *)progressBottomGradientColor {
  _progressBottomGradientColor = progressBottomGradientColor;

  [self setNeedsDisplay];
}

@end