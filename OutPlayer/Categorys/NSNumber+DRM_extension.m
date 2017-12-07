//
//  NSNumber+DRM_extension.m
//  DRMonline
//
//  Created by xl on 17/7/27.
//  Copyright © 2017年 SunRoam. All rights reserved.
//

#import "NSNumber+DRM_extension.h"

@implementation NSNumber (DRM_extension)

#pragma mark - caches
- (NSString *)cachesFormat {
    //  self 文件大小,单位为byte
    NSString *cachesStr;
    NSInteger intSize = [self longLongValue];
    NSInteger oneg = 1024*1024*1024;
    NSInteger onek = 1024;
    NSInteger onem = 1024*1024;
    if (intSize >= oneg) {  // 显示G
        cachesStr = [NSString stringWithFormat:@"%.1fG",intSize *1.0 /oneg];
    } else if (intSize <= onek) {  // 显示k
        cachesStr = [NSString stringWithFormat:@"%.1fKb",intSize *1.0 / onek];
    } else {  // 显示M
        cachesStr = [NSString stringWithFormat:@"%.1fM",intSize *1.0 /onem];
    }
    return cachesStr;
}
@end
