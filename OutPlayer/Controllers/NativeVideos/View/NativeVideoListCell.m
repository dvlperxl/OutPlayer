//
//  NativeVideoListCell.m
//  OutPlayer
//
//  Created by xl on 2017/12/7.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "NativeVideoListCell.h"
#import "NativeVideoFile.h"

@interface NativeVideoListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoSizeLabel;
@end

@implementation NativeVideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.thumbImageView.image = [UIImage imageNamed:@"rd_error_long"];
}

- (void)bindingViewModel:(NativeVideoFile *)viewModel {
    if (viewModel.videoThumb) {
        self.thumbImageView.image = viewModel.videoThumb;
    }
    self.videoTitleLabel.text = viewModel.videoTitle;
    self.videoSizeLabel.text = viewModel.videoSize;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
