//
//  MediaThumbTool.h
//  OutPlayer
//
//  Created by xl on 2017/12/13.
//  Copyright © 2017年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MediaThumbToolCompletedBlock)(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished);
@interface MediaThumbTool : NSObject

+ (nullable instancetype)sharedInstance;
- (void)thumbForUrl:(NSURL *_Nullable)url completed:(nullable MediaThumbToolCompletedBlock)completedBlock;
@end
