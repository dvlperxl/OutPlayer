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

@interface NativeVideosHomeController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
@property (nonatomic,strong) UIView *emptyDataView;
@property (nonatomic,strong) NSMutableArray *nativeVideos;
@end

@implementation NativeVideosHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}
- (void)setupUI {
    [self.tableView cyl_reloadData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}
- (void)loadData {
    NativeVideosServe *serve = [[NativeVideosServe alloc]init];
    [serve nativeVideosCompletion:^(NSArray *videos) {
        self.nativeVideos = [NSArray yy_modelArrayWithClass:[NativeVideoFile class] json:videos].mutableCopy;
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        [self reloadUI];
    }];
}
- (void)reloadUI {
    [self.tableView cyl_reloadData];
    [self reloadCachesLabel];
}

- (void)reloadCachesLabel {
    // 总空间
    NSString *totalDiskSize = [RDSandboxTool diskOfAllSize].cachesFormat;
    // 可用空间
    NSString *freeDiskSize = [RDSandboxTool diskOfFreeSize].cachesFormat;
    self.cacheLabel.text = [NSString stringWithFormat:@"总空间%@，可用空间%@",totalDiskSize,freeDiskSize];
}
#pragma mark - CYLTableViewPlaceHolderDelegate
- (UIView *)makePlaceHolderView {
    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor redColor];
    return view;
}
- (BOOL)enableScrollWhenPlaceHolderViewShowing {
    return YES;
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
            [self reloadCachesLabel];
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
