//
//  BaseHeader.h
//  ReadPSY
//
//  Created by Eric on 16/10/10.
//  Copyright © 2016年 Eric. All rights reserved.
//

#ifndef BaseHeader_h
#define BaseHeader_h

// 字符串是否为空
#define STR_IS_NIL(string) [string isEmpty]

// 获取storyboard中的ViewController
#define VCFrom(storyboard,identifier) [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:identifier]

#pragma mark - 版本
//当前系统版本号
#define kSystemVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//当前设备版本号
#define kDeviceVersion [[[UIDevice currentDevice] systemVersion] doubleValue]

#pragma mark - 颜色
#define kRGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kRGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#endif /* BaseHeader_h */
