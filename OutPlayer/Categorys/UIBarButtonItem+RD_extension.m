//
//  UIBarButtonItem+RD_extension.m
//  ReadPSY
//
//  Created by xl on 16/10/18.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "UIBarButtonItem+RD_extension.h"

@implementation UIBarButtonItem (RD_extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    if (image&&image.length!=0) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highImage&&highImage.length!=0) {
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    // 设置尺寸
    btn.bounds =CGRectMake(0, 0, 44, 44);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 20, 5, 0)];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage levelEdge:(CGFloat)edge;
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    if (image&&image.length!=0) {
        [btn setImage:[UIImage imageNamed:image]forState:UIControlStateNormal];
    }
    if (highImage&&highImage.length!=0) {
        [btn setImage:[UIImage imageNamed:highImage]forState:UIControlStateHighlighted];
    }
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -edge, 0, edge)];
    // 设置尺寸
    btn.bounds =CGRectMake(0, 0, 40, 40);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title normalColor:(UIColor *)normalColor highColor:(UIColor *)highColor disabledColor:(UIColor *)disabledColr
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    if (normalColor) {
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (highColor) {
        [btn setTitleColor:highColor forState:UIControlStateHighlighted];
    }
    if (disabledColr) {
        [btn setTitleColor:disabledColr forState:UIControlStateDisabled];
    }
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn sizeToFit];
    if (btn.bounds.size.width < 40) {
        btn.bounds=CGRectMake(0, 0, 40, 40);
    }
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

/** 带图片和文字的Item*/
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title normalColor:(UIColor *)normalColor image:(NSString *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    if (normalColor) {
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (image&&image.length!=0) {
        [btn setImage:[UIImage imageNamed:image]forState:UIControlStateNormal];
    }
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn sizeToFit];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0,0)];
//    btn.bounds =CGRectMake(0, 0, 60, 44);

    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
