//
//  NSString+WDUtils.m
//  HBModelMarket
//
//  Created by William REN on 7/14/15.
//  Copyright (c) 2015 Eric. All rights reserved.
//

#import "NSString+WDUtils.h"

@implementation NSString (WDUtils)

- (BOOL)isEmpty {
    return  (nil == self || [self isKindOfClass:[NSNull class]] || ([self length] == 0) || [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]);
}

- (BOOL)isCellphoneNumber {
    if (self) {
        //电话号码，包括手机号，坐机号，400电话
        NSArray *nums = [self componentsSeparatedByString:@","];
        NSString *filterMobileNum = [nums objectAtIndex:0];
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         * 联通：130,131,132,152,155,156,185,186
         * 电信：133,1349,153,180,181,189
         */
        
        NSString * PHONE = @"^\\d{11}$";  //11位手机号
        NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        /**
         10         * 中国移动：China Mobile
         11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         12         */
        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
        /**
         15         * 中国联通：China Unicom
         16         * 130,131,132,152,155,156,185,186
         17         */
        NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
        /**
         20         * 中国电信：China Telecom
         21         * 133,1349,153,180,181,189
         22         */
        NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
        /**
         25         * 大陆地区固话及小灵通
         26         * 区号：010,020,021,022,023,024,025,027,028,029
         27         * 号码：七位或八位
         28         */
        NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
        NSString * PHSS = @"^\\d{7,8}$";   //8位不带区号
        NSString * SERVICE = @"^\\d{5}$";  //5位客服
        
        NSPredicate *regextestPhone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHONE];
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
        NSPredicate *regextestphss = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHSS];
        NSPredicate *regextestser = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", SERVICE];
        
        if (([regextestPhone evaluateWithObject:filterMobileNum] == YES)
            || ([regextestmobile evaluateWithObject:filterMobileNum] == YES)
            || ([regextestcm evaluateWithObject:filterMobileNum] == YES)
            || ([regextestct evaluateWithObject:filterMobileNum] == YES)
            || ([regextestcu evaluateWithObject:filterMobileNum] == YES)
            || ([regextestphs evaluateWithObject:filterMobileNum] == YES)
            || ([regextestphss evaluateWithObject:filterMobileNum] == YES)
            || ([regextestser evaluateWithObject:filterMobileNum] == YES)){
            return YES;
        }
        if (filterMobileNum.length<=3) {
            return NO;
        }
        //对14开头的号码，认为是合法的
        if ([[filterMobileNum substringToIndex:2]isEqualToString:@"14"]) {
            return YES;
        }
        //400电话认为是合法的
        if ([[filterMobileNum substringToIndex:3]isEqualToString:@"400"]) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

//得到当前时间 
+(NSString *)GetNowTimes
{
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSString *timetemp = [NSString stringWithFormat:@"%.0f",time];
    return timetemp;
}

/** 获取n天前的时间 yyyy-MM-dd*/
+ (NSString *)getTimeBefore:(NSInteger)day {
    NSDate *nowDate = [NSDate date];
    NSDate *theDate;
    //1天的长度
    NSTimeInterval oneDay = 24*60*60*1;
    //之前的天数
    theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*day];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * beforeDayTime = [dateFormatter stringFromDate:theDate];
    return beforeDayTime;
}

/** 获取n天前的时间 格式：yyyy.MM.dd*/
+ (NSString *)getTimeWithDropFormatterBefore:(NSInteger)day {
    NSDate *nowDate = [NSDate date];
    NSDate *theDate;
    //1天的长度
    NSTimeInterval oneDay = 24*60*60*1;
    //之前的天数
    theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*day];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString * beforeDayTime = [dateFormatter stringFromDate:theDate];
    return beforeDayTime;
}
// 根据时间戳转换成 上午yyyy.mm.dd 的格式。timeInterval单位是秒
+ (NSString *)dropDateFormatForTimeInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    dateFormatter.locale = locale;
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

// 根据时间戳转换成 上午yyyy/mm/dd 的格式。timeInterval单位是秒
+ (NSString *)dateFormatForTimeInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    dateFormatter.locale = locale;
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}
//自适应
- (CGSize)frameForFont:(UIFont*)font
{
    return [self frameForFont:font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].size;
}

- (CGSize)sizeForFont:(UIFont*)font constrainedToSize:(CGSize)size
{
    return [self frameForFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping].size;
}
- (CGSize)sizeForFont:(UIFont*)font constrainedToWidth:(CGFloat)width {
    return [self frameForFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].size;
}
- (CGRect)frameForFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect textRect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return textRect;
}

//播放器时间转换
+ (NSString *)converTime:(CGFloat)second
{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    }else{
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

@end
