//
//  NativeVideoPlayerController.h
//  OutPlayer
//
//  Created by xl on 2017/12/15.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "BaseViewController.h"

@interface NativeVideoPlayerController : BaseViewController

@property (nonatomic,strong) NSURL *mediaUrl;
@property (nonatomic,copy) NSString *videoTitle;
@property (nonatomic,strong) UIImage *videoThumb;
@end
