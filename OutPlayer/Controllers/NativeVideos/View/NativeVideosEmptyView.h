//
//  NativeVideosEmptyView.h
//  OutPlayer
//
//  Created by xl on 2017/12/19.
//  Copyright © 2017年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NativeVideosEmptyViewDelegate <NSObject>

@required
- (void)emptyOverlayClicked:(id)sender;

@end

@interface NativeVideosEmptyView : UIView

@property (nonatomic, weak) id<NativeVideosEmptyViewDelegate> delegate;
@end
