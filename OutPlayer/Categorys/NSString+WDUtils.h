//
//  NSString+WDUtils.h
//  HBModelMarket
//
//  Created by William REN on 7/14/15.
//  Copyright (c) 2015 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WDUtils)

- (BOOL)isEmpty;
- (BOOL)isEmail;
- (BOOL)isCellphoneNumber;

//得到当前时间
+ (NSString *)GetNowTimes;
/** 获取n天前的时间 yyyy-MM-dd*/
+ (NSString *)getTimeBefore:(NSInteger)day;
/** 获取n天前的时间 格式：yyyy.MM.dd*/
+ (NSString *)getTimeWithDropFormatterBefore:(NSInteger)day;
// 根据时间戳转换成 上午yyyy.mm.dd 的格式。timeInterval单位是秒
+ (NSString *)dropDateFormatForTimeInterval:(NSTimeInterval)timeInterval;
// 根据时间戳转换成 上午yyyy/mm/dd 的格式。timeInterval单位是秒
+ (NSString *)dateFormatForTimeInterval:(NSTimeInterval)timeInterval;
//自适应
- (CGSize)frameForFont:(UIFont*)font;
- (CGRect)frameForFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)sizeForFont:(UIFont*)font constrainedToSize:(CGSize)size;
- (CGSize)sizeForFont:(UIFont*)font constrainedToWidth:(CGFloat)width;
//播放器时间转换
+ (NSString *)converTime:(CGFloat)second;


@end
