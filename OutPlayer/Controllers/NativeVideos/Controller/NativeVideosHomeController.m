//
//  NativeVideosHomeController.m
//  OutPlayer
//
//  Created by xl on 2017/12/6.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "NativeVideosHomeController.h"
#import "NativeVideosServe.h"
#import "NativeVideoFile.h"
#import "NativeVideoListCell.h"
#import "NativeVideoPlayerController.h"

@interface NativeVideosHomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *nativeVideos;
@end

@implementation NativeVideosHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    NativeVideosServe *serve = [[NativeVideosServe alloc]init];
    [serve nativeVideosCompletion:^(NSArray *videos) {
        self.nativeVideos = [NSArray yy_modelArrayWithClass:[NativeVideoFile class] json:videos].mutableCopy;
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nativeVideos.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NativeVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NativeVideoListCell class])];
    NativeVideoFile *video = self.nativeVideos[indexPath.row];
    [cell bindingViewModel:video];
    return cell;
}
#pragma mark - UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NativeVideoFile *video = self.nativeVideos[indexPath.row];
        NativeVideosServe *serve = [[NativeVideosServe alloc]init];
        if ([serve removeVideoAtURL:video.videoUrl]) {  // 本地删除成功
            [self.nativeVideos removeObject:video];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    return @[action];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NativeVideoFile *video = self.nativeVideos[indexPath.row];
    NativeVideoPlayerController *playerVC = VCFrom(@"NativeVideos", @"NativeVideoPlayerController");
    playerVC.mediaUrl = video.videoUrl;
    playerVC.videoTitle = video.videoTitle;
    playerVC.videoThumb = video.videoThumb;
    [self.navigationController pushViewController:playerVC animated:YES];
}
@end
