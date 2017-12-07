//
//  UIImage+DRMExtension.h
//  DRMonline
//
//  Created by xl on 16/9/22.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (DRMExtension)

/** 获取视频第xx秒的帧图片*/
+ (UIImage *)imageWithAsset:(AVAsset *)asset time:(NSTimeInterval)atTime;

/** 剪成圆形图片*/
- (UIImage *)DRM_circleImage;
@end
