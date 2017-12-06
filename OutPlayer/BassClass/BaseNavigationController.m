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
    UINavigationBar *navBar=[UINavigationBar appearance];
    // 设置导航条为不透明
    [navBar setTranslucent:NO];
    //导航栏背景颜色
//    [navBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexString:RDColorNavBg]] forBarMetrics:UIBarMetricsDefault];
//    [navBar setBarTintColor:[UIColor colorWithHexString:RDColorNavBg]];
    
    // 自定义返回
    UIImage *backButtonImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navBar.backIndicatorImage = backButtonImage;
    navBar.backIndicatorTransitionMaskImage = backButtonImage;
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    // 自定义返回
//    UIImage *backButtonImage_OFF = [[UIImage imageNamed:@"icon_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//    // 调整箭头距左间距 (右移5)
//    UIImage *adjustImage;
//    if (kDeviceVersion > 9.0) {
//        adjustImage = [backButtonImage_OFF imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
//    } else {
//        adjustImage = [backButtonImage_OFF imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, -2, 0, 0)];
//    }
//    [item setBackButtonBackgroundImage:adjustImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

@end
