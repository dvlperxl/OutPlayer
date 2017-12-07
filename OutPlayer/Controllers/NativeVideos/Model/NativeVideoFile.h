//
//  NativeVideoFile.h
//  OutPlayer
//
//  Created by xl on 2017/12/7.
//  Copyright © 2017年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NativeVideoFile : NSObject

/** 播放地址*/
@property (nonatomic,strong) NSURL *videoUrl;
/** 视频名称*/
@property (nonatomic,copy) NSString *videoTitle;
/** 视频缩略图*/
@property (nonatomic,strong) UIImage *videoThumb;
/** 文件大小*/
@property (nonatomic,strong) NSString *videoSize;
/** 第几秒开始播放*/
@property (nonatomic,assign) NSInteger seekTime;
@end
