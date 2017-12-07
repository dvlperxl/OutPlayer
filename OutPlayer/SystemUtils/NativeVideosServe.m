//
//  NativeVideosServe.m
//  OutPlayer
//
//  Created by xl on 2017/12/7.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "NativeVideosServe.h"
#import <AVFoundation/AVFoundation.h>

NSInteger const videoThumbAtTime = 5;

@implementation NativeVideosServe

#pragma mark - public
- (NSArray *)nativeVideos {
    return [self videosForDirectory:[RDSandboxTool DocumentsDirectory]];
}
- (BOOL)removeVideoAtURL:(NSURL *)url {
    return [RDSandboxTool removeFileWithUrl:url];
}
#pragma mark - private
- (NSArray *)videosForDirectory:(NSString *)directory {
    if (!directory) {
        return nil;
    }
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *fileNames = [fileMgr contentsOfDirectoryAtPath:directory error:nil];
    if (!fileNames || fileNames.count == 0) {
        return nil;
    }
    NSMutableArray *videos = [NSMutableArray arrayWithCapacity:fileNames.count];
    for (NSString *fileName in fileNames) {
        BOOL flag = YES;
        NSString* fullPath = [directory stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {  // 是文件，非文件夹
                // 判断是否是视频文件
                AVAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:fullPath]];
                NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
                BOOL hasVideoTrack = [tracks count] > 0;
                if (hasVideoTrack) {
                    NSMutableDictionary *video = [NSMutableDictionary dictionary];
                    // 视频名称
                    [video setObject:fileName forKey:@"videoTitle"];
                    // 播放地址
                    [video setObject:[NSURL fileURLWithPath:fullPath] forKey:@"videoUrl"];
                    // 文件大小
                    [video setObject:[RDSandboxTool fileSizeByteNumbWithPath:fullPath].cachesFormat forKey:@"videoSize"];
                    // 视频缩略图
                    [video setObject:[UIImage imageWithAsset:asset time:videoThumbAtTime] forKey:@"videoThumb"];
                    [videos addObject:video.copy];
                }
            }
        }
    }
    return videos.copy;
}


@end
