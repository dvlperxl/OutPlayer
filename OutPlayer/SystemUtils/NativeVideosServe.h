//
//  NativeVideosServe.h
//  OutPlayer
//
//  Created by xl on 2017/12/7.
//  Copyright © 2017年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NativeVideosServe : NSObject

/**
 获取本地视频（Documents文件夹下）
 */
- (void)nativeVideosCompletion:(void (^)(NSArray *videos))completionBlock;
/**
 删除视频
 */
- (BOOL)removeVideoAtURL:(NSURL *)url;
@end
