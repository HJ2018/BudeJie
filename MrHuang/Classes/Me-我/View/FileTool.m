//
//  FileTool.m
//  MrHuang
//
//  Created by jie.huang on 2018/4/28.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import "FileTool.h"

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@implementation FileTool



// 自己去计算SDWebImage做的缓存
+(NSInteger)getFileSize:(NSString *)directoryPath
{
    // NSFileManager
    // attributesOfItemAtPath:指定文件路径,就能获取文件属性
    // 把所有文件尺寸加起来
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取文件夹下所有的子路径,包含子路径的子路径
    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
    
    NSInteger totalSize = 0;
    
    for (NSString *subPath in subPaths) {
        // 获取文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 判断隐藏文件
        if ([filePath containsString:@".DS"]) continue;
        
        // 判断是否文件夹
        BOOL isDirectory;
        // 判断文件是否存在,并且判断是否是文件夹
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        // 获取文件属性
        // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        
        // 获取文件尺寸
        NSInteger fileSize = [attr fileSize];
        
        totalSize += fileSize;
    }
    
    return totalSize;
    
}

+(void)removeDirectoryPath:(NSString *)DirectoryPath{
    // 清空缓存
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    
    // 判断是否文件夹
    BOOL isDirectory;
    // 判断文件是否存在,并且判断是否是文件夹
    BOOL isExist = [mgr fileExistsAtPath:DirectoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        
        /**
         错了 崩溃

         @param NSString 名称
         @return 报错原因
         */
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入文件并且路径要存在" userInfo:nil];
        
        [excp raise];
        
    }
    
    // 获取cache文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:DirectoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [DirectoryPath stringByAppendingPathComponent:subPath];
        
        // 删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }
}

// 获取缓存尺寸字符串
+ (NSString *)sizeStr
{
    // 获取Caches文件夹路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSInteger totalSize = [self getFileSize:cachePath];
    
    NSString *sizeStr = @"清除缓存";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    
    return sizeStr;
}

@end
