//
//  NativeVideoPlayerController.m
//  OutPlayer
//
//  Created by xl on 2017/12/15.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "NativeVideoPlayerController.h"
#import "ZFPlayer.h"

@interface NativeVideoPlayerController ()

@property (weak, nonatomic) IBOutlet UIView *fatherPlayerView;
@property (nonatomic,strong) ZFPlayerView *player;
@end

@implementation NativeVideoPlayerController
- (void)dealloc {
    NSLog(@"%@释放了",self.class);
    [self.player stop];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc]init];
    playerModel.title = self.videoTitle;
    playerModel.videoURL = self.mediaUrl;
    playerModel.placeholderImage = self.videoThumb;
    playerModel.fatherView = self.fatherPlayerView;
    playerModel.seekTime = 10 * 1000;
    
    [self.player playerModel:playerModel];
    [self.player autoPlayTheVideo];
}

#pragma mark - getter
- (ZFPlayerView *)player {
    if (!_player) {
        _player = [[ZFPlayerView alloc] init];
    }
    return _player;
}


@end
