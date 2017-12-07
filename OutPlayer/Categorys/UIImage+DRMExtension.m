//
//  UIImage+DRMExtension.m
//  DRMonline
//
//  Created by xl on 16/9/22.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "UIImage+DRMExtension.h"

@implementation UIImage (DRMExtension)

/** 获取视频第xx秒的帧图片*/
+ (UIImage *)imageWithAsset:(AVAsset *)asset time:(NSTimeInterval)atTime {
    if (!asset) {
        return nil;
    }
    NSError *error;
    CMTime actualTime;
    CMTime dragedCMTime = CMTimeMake(atTime, 1);
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:dragedCMTime actualTime:&actualTime error:&error];
    CMTimeShow(actualTime);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

- (UIImage *)DRM_circleImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
