//
//  NativeVideosEmptyView.m
//  OutPlayer
//
//  Created by xl on 2017/12/19.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "NativeVideosEmptyView.h"

static float const kUIemptyOverlayLabelX         = 0;
static float const kUIemptyOverlayLabelY         = 0;
static float const kUIemptyOverlayLabelHeight    = 20;

@interface NativeVideosEmptyView ()

@property (nonatomic, strong) UIImageView *emptyOverlayImageView;
@property (nonatomic, strong) UILabel *emptyOverlayLabel;
@end


@implementation NativeVideosEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)sharedInit {
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.contentMode =   UIViewContentModeTop;
    [self addUIemptyOverlayImageView];
    [self addUIemptyOverlayLabel];
    [self addUIemptyOverlayButton];
    return self;
}

- (void)addUIemptyOverlayImageView {
    self.emptyOverlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 - 100);
    self.emptyOverlayImageView.image = [UIImage imageNamed:@"WebView_LoadFail_Refresh_Icon"];
    [self addSubview:self.emptyOverlayImageView];
}

- (void)addUIemptyOverlayLabel {
    CGRect emptyOverlayViewFrame = CGRectMake(kUIemptyOverlayLabelX, kUIemptyOverlayLabelY, CGRectGetWidth(self.frame), kUIemptyOverlayLabelHeight);
    UILabel *emptyOverlayLabel = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
    emptyOverlayLabel.textAlignment = NSTextAlignmentCenter;
    emptyOverlayLabel.numberOfLines = 0;
    emptyOverlayLabel.backgroundColor = [UIColor clearColor];
    emptyOverlayLabel.text = @"您还没有导入任何视频哦";
    emptyOverlayLabel.font = [UIFont systemFontOfSize:16];
    emptyOverlayLabel.frame = ({
        CGRect frame = emptyOverlayLabel.frame;
        frame.origin.y = CGRectGetMaxY(self.emptyOverlayImageView.frame) + 10;
        frame;
    });
    emptyOverlayLabel.textColor = [UIColor grayColor];
    [self addSubview:emptyOverlayLabel];
    self.emptyOverlayLabel = emptyOverlayLabel;
}
- (void)addUIemptyOverlayButton {
    UIButton *emptyOverlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emptyOverlayButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [emptyOverlayButton setTitle:@"如何导入" forState:UIControlStateNormal];
    [emptyOverlayButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [emptyOverlayButton addTarget:self action:@selector(emptyOverlayClicked:) forControlEvents:UIControlEventTouchUpInside];
    [emptyOverlayButton sizeToFit];
    emptyOverlayButton.frame = CGRectMake(0, 0, emptyOverlayButton.bounds.size.width, emptyOverlayButton.bounds.size.height);
    emptyOverlayButton.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetMaxY(self.emptyOverlayLabel.frame) + 20);
    [self addSubview:emptyOverlayButton];
}

- (void)emptyOverlayClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(emptyOverlayClicked:)]) {
        [self.delegate emptyOverlayClicked:sender];
    }
}

@end
