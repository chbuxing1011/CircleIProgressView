//
//  ViewController.m
//  HsProfitRatePie
//
//  Created by snailgame on 15/7/2.
//  Copyright (c) 2015年 SnailGame. All rights reserved.
//

#import "ViewController.h"
#import "HsProfitRatePieWidgets.h"
#import "LinearGridentView.h"
#import "GridentView.h"
@interface ViewController ()
@property(nonatomic, strong) IBOutlet HsProfitRatePieWidgets *circleProgress;
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.circleProgress setProgressTopGradientColor:[UIColor yellowColor]];
  [self.circleProgress setProgressBottomGradientColor:[UIColor orangeColor]];

  [self.circleProgress setInnerBackgroundColor:[UIColor clearColor]];
  [self.circleProgress setOuterBackgroundColor:[UIColor clearColor]];
  self.circleProgress.font = [UIFont systemFontOfSize:30];
  self.circleProgress.progress = 0.00f;
  self.circleProgress.unit = @"分";

  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                                target:self
                                              selector:@selector(timerFired)
                                              userInfo:nil
                                               repeats:YES];

  [self.view addSubview:self.circleProgress];

  [self.timer fire];
    
    LinearGridentView *linearView = [[LinearGridentView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    linearView.backgroundColor = [UIColor lightGrayColor];
    linearView.opaque = NO;
    [self.view addSubview:linearView];
    

    
    GridentView *gridentView = [[GridentView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    gridentView.backgroundColor = [UIColor lightGrayColor];
    gridentView.opaque = NO;
    [self.view addSubview:gridentView];
}

- (void)timerFired {
  self.circleProgress.progress = self.circleProgress.progress + 0.01f;
  if (self.circleProgress.progress >= 1.0f) {
    [self.timer invalidate];
  }
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
