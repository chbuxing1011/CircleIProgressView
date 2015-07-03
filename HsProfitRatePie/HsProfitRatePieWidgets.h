//
//  HsProfitRatePieWidgets.h
//  HsProfitRatePie
//
//  Created by snailgame on 15/7/2.
//  Copyright (c) 2015年 SnailGame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HsProfitRatePieWidgets : UIView {
  UILabel *_textLabel;
  UILabel *_descLabel;
  UIImageView *_bgImageView;
}
@property(nonatomic, strong) NSString *unit;
@property(nonatomic) double progress;

@property(nonatomic) NSInteger showText UI_APPEARANCE_SELECTOR;
@property(nonatomic) NSInteger roundedHead UI_APPEARANCE_SELECTOR;
@property(nonatomic) NSInteger showShadow UI_APPEARANCE_SELECTOR;

@property(nonatomic) CGFloat thicknessRatio UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong)
    UIColor *innerBackgroundColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong)
    UIColor *outerBackgroundColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong) UIColor *progressFillColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong)
    UIColor *progressTopGradientColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong)
    UIColor *progressBottomGradientColor UI_APPEARANCE_SELECTOR;

@end