//
//  NativeVideosServe.m
//  OutPlayer
//
//  Created by xl on 2017/12/7.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "NativeVideosServe.h"
#import "MediaThumbTool.h"

NSInteger const videoThumbAtTime = 5;

@interface NativeVideosServe ()

@property (nonatomic,copy) NSArray *supportMediaTypeList;
@end

@implementation NativeVideosServe

#pragma mark - public
- (void)nativeVideosCompletion:(void (^)(NSArray *videos))completionBlock {
    [self videosForDirectory:[RDSandboxTool DocumentsDirectory] completion:completionBlock];
}
- (BOOL)removeVideoAtURL:(NSURL *)url {
    return [RDSandboxTool removeFileWithUrl:url];
}
#pragma mark - private
- (void)videosForDirectory:(NSString *)directory completion:(void (^)(NSArray *videos))completionBlock {
    if (!directory) {
        if (completionBlock) {
            completionBlock(nil);
        }
    }
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *fileNames = [fileMgr contentsOfDirectoryAtPath:directory error:nil];
    if (!fileNames || fileNames.count == 0) {
        if (completionBlock) {
            completionBlock(nil);
        }
    }
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray *videos = [NSMutableArray arrayWithCapacity:fileNames.count];
    for (NSString *fileName in fileNames) {
        BOOL flag = YES;
        NSString *fullPath = [directory stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {  // 是文件，非文件夹
                NSString *extension = [fileName.pathExtension lowercaseString];
                if ([self.supportMediaTypeList containsObject:extension]) {  // 是播放器支持的格式
                    dispatch_group_enter(group);
                    NSMutableDictionary *video = [NSMutableDictionary dictionary];
                    // 视频名称
                    [video setObject:fileName forKey:@"videoTitle"];
                    // 播放地址
                    [video setObject:[NSURL fileURLWithPath:fullPath] forKey:@"videoUrl"];
                    // 文件大小
                    [video setObject:[RDSandboxTool fileSizeByteNumbWithPath:fullPath].cachesFormat forKey:@"videoSize"];
                    // 视频缩略图
                    [[MediaThumbTool sharedInstance]thumbForUrl:[NSURL fileURLWithPath:fullPath] completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
                        [video setObject:image forKey:@"videoThumb"];
                        [videos addObject:video.copy];
                        dispatch_group_leave(group);
                    }];
                }
            }
        }
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completionBlock) {
            completionBlock(videos);
        }
    });
}

#pragma mark - getter
- (NSArray *)supportMediaTypeList {
    if (!_supportMediaTypeList) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"SupportedMediaType" ofType:@"plist"];
        _supportMediaTypeList = [NSArray arrayWithContentsOfFile:file];
    }
    return _supportMediaTypeList;
}
@end
