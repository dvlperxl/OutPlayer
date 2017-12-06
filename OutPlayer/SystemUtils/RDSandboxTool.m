//
//  RDSandboxTool.m
//  ReadPSY
//
//  Created by xl on 16/11/21.
//  Copyright © 2016年 SunRoam. All rights reserved.
//

#import "RDSandboxTool.h"

@implementation RDSandboxTool

/** Documents路径*/
+ (NSString *)DocumentsDirectory {
    static NSString *documentPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    });
    return documentPath;
}

/** Library路径*/
+ (NSString *)LibraryDirectory {
    static NSString *libraryPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    });
    return libraryPath;
}

/** Library/Caches路径*/
+ (NSString *)CachesDirectory {
    static NSString *cachesPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    });
    return cachesPath;
}
/** Library/Preferences路径*/
+ (NSString *)LibPreferencesDirectory {
    static NSString *preferencesPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        preferencesPath = [[self LibraryDirectory] stringByAppendingPathComponent:@"Preferences"];
    });
    return preferencesPath;
}

/** 添加文件夹路径*/
+ (NSString *)createFolder:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if(![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if(!error)
        {
            NSLog(@"%@",[error description]);
        }
    }
    return path;
}
/**  是否存在文件*/
+ (BOOL)isExistFile:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:fileName];
}

/**
 文件大小
 @param path 文件路径，可传文件夹路径或者文件路径
 */
+ (NSUInteger)fileSizeWithPath:(NSString *)path {
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:path isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    if (dir) { // 是一个文件夹
        // 遍历path里面的所有内容
        NSArray *subpaths = [mgr subpathsAtPath:path];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [path stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // 是一个文件
        return [[mgr attributesOfItemAtPath:path error:nil][NSFileSize] integerValue];
    }
}
/** 删除文件/文件夹*/
+ (BOOL)removeFileWithPath:(NSString *)path {
    NSFileManager *mgr = [NSFileManager defaultManager];
    return [mgr removeItemAtPath:path error:nil];
}

// 磁盘总空间大小
+ (CGFloat)diskOfAllSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

// 磁盘可用空间大小
+ (CGFloat)diskOfFreeSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}
@end
