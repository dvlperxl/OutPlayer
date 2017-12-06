//
//  BaseNavigationController.m
//  ReadPSY
//
//  Created by Eric on 16/10/10.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置导航条为不透明
    [navBar setTranslucent:NO];
    //导航栏背景颜色
//    [navBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexString:RDColorNavBg]] forBarMetrics:UIBarMetricsDefault];
//    [navBar setBarTintColor:[UIColor colorWithHexString:RDColorNavBg]];
    
    // 自定义返回
    UIImage *backButtonImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navBar.backIndicatorImage = backButtonImage;
    navBar.backIndicatorTransitionMaskImage = backButtonImage;
}

@end
