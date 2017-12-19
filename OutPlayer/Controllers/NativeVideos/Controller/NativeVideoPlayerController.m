//
//  NativeVideoPlayerController.m
//  OutPlayer
//
//  Created by xl on 2017/12/15.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "NativeVideoPlayerController.h"
#import "ZFPlayer.h"

@interface NativeVideoPlayerController ()<ZFPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *fatherPlayerView;
@property (nonatomic,strong) ZFPlayerView *player;
@end

@implementation NativeVideoPlayerController
- (void)dealloc {
    [self.player stop];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden {
    return ZFPlayerShared.isStatusBarHidden;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc]init];
    playerModel.title = self.videoTitle;
    playerModel.videoURL = self.mediaUrl;
    playerModel.placeholderImage = self.videoThumb;
    playerModel.fatherView = self.fatherPlayerView;
    
    [self.player playerModel:playerModel];
    [self.player autoPlayTheVideo];
}
#pragma mark - ZFPlayerDelegate
- (void)zf_playerBackAction {
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - getter
- (ZFPlayerView *)player {
    if (!_player) {
        _player = [[ZFPlayerView alloc] init];
        _player.onlySupportFullScreen = YES;
        _player.delegate = self;
    }
    return _player;
}


@end
