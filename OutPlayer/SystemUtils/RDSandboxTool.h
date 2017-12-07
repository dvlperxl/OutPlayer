//
//  RDSandboxTool.h
//  ReadPSY
//
//  Created by xl on 16/11/21.
//  Copyright © 2016年 SunRoam. All rights reserved.
//  沙盒操作工具

#import <Foundation/Foundation.h>

@interface RDSandboxTool : NSObject


/** Documents路径*/
+ (NSString *)DocumentsDirectory;

/** Library路径*/
+ (NSString *)LibraryDirectory;

/** Library/Caches路径*/
+ (NSString *)CachesDirectory;

/** Library/Preferences路径*/
+ (NSString *)LibPreferencesDirectory;

/** 添加文件夹路径*/
+ (NSString *)createFolder:(NSString *)path;

/** 是否存在文件*/
+ (BOOL)isExistFile:(NSString *)fileName;

/**
  文件大小,单位为byte
 @param path 文件路径，可传文件夹路径或者文件路径
 */
+ (NSUInteger)fileSizeWithPath:(NSString *)path;
+ (NSNumber *)fileSizeByteNumbWithPath:(NSString *)path;

/** 删除文件/文件夹*/
+ (BOOL)removeFileWithPath:(NSString *)path;
+ (BOOL)removeFileWithUrl:(NSURL *)url;

/** 磁盘总空间大小 */ 
+ (NSNumber *)diskOfAllSize;

/** 磁盘可用空间大小*/
+ (NSNumber *)diskOfFreeSize;

@end
