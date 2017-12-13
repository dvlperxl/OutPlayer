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
    [serve nativeVideosAsyncBlock:^(NSArray *videos) {
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}
@end
