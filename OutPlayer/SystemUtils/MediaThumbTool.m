//
//  MediaThumbTool.m
//  OutPlayer
//
//  Created by xl on 2017/12/13.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "MediaThumbTool.h"
#import <MobileVLCKit/MobileVLCKit.h>

@interface MediaThumbTool ()<VLCMediaThumbnailerDelegate>

@property (nonatomic,strong) NSMutableDictionary *completedBlockDic;
@end

@implementation MediaThumbTool

+ (instancetype)sharedInstance {
    static MediaThumbTool *thumbTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thumbTool = [[MediaThumbTool alloc]init];
    });
    return thumbTool;
}

- (void)thumbForUrl:(NSURL *_Nullable)url completed:(nullable MediaThumbToolCompletedBlock)completedBlock {
    if (!url) {
        if (completedBlock) {
            NSError *error = [NSError errorWithDomain:@"ErrorFromInput" code:404 userInfo:@{NSLocalizedDescriptionKey:@"地址为空"}];
            completedBlock(nil,error,NO);
        }
        return;
    }
    if (completedBlock) {
        [self.completedBlockDic setObject:completedBlock forKey:url.absoluteString];
        VLCMedia *media = [VLCMedia mediaWithURL:url];
        VLCMediaThumbnailer *thumbnailer = [VLCMediaThumbnailer thumbnailerWithMedia:media andDelegate:self];
        [thumbnailer fetchThumbnail];
    }
}

#pragma mark - VLCMediaThumbnailerDelegate
- (void)mediaThumbnailerDidTimeOut:(VLCMediaThumbnailer *)mediaThumbnailer {
    MediaThumbToolCompletedBlock completedBlock = [self.completedBlockDic objectForKey:mediaThumbnailer.media.url.absoluteString];
    if (completedBlock) {
        NSError *error = [NSError errorWithDomain:@"ErrorFromInput" code: 400 userInfo:@{NSLocalizedDescriptionKey:@"无法获取帧图片"}];
        completedBlock(nil,error,NO);
        [self.completedBlockDic removeObjectForKey:mediaThumbnailer.media.url.absoluteString];
    }
    
}
- (void)mediaThumbnailer:(VLCMediaThumbnailer *)mediaThumbnailer didFinishThumbnail:(CGImageRef)thumbnail {
    MediaThumbToolCompletedBlock completedBlock = [self.completedBlockDic objectForKey:mediaThumbnailer.media.url.absoluteString];
    if (completedBlock) {
        completedBlock([UIImage imageWithCGImage:thumbnail],nil,YES);
        [self.completedBlockDic removeObjectForKey:mediaThumbnailer.media.url.absoluteString];
    }
}

#pragma mark - getter
- (NSMutableDictionary *)completedBlockDic {
    if (!_completedBlockDic) {
        _completedBlockDic = [NSMutableDictionary dictionary];
    }
    return _completedBlockDic;
}
@end
