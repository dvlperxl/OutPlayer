//
//  MainViewController.m
//  OutPlayer
//
//  Created by xl on 2017/12/6.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:VCFrom(@"NativeVideos", @"NativeVideosHomeController") title:@"本地视频" imageName:@"tab_recommendation" selectedImageName:@""];
    [self addChildViewController:VCFrom(@"LeadVideos", @"LeadVideosController") title:@"导入视频" imageName:@"tab_recommendation" selectedImageName:@""];
    [self addChildViewController:VCFrom(@"Setting", @"SettingController") title:@"设置" imageName:@"tab_recommendation" selectedImageName:@""];
}

// 添加ChildViewController
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    childController.title = title;
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectedImage;
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@""];
    [childController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}
@end
