//
//  FileTool.h
//  MrHuang
//
//  Created by jie.huang on 2018/4/28.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject


+(NSInteger)getFileSize:(NSString *)directoryPath;

/**
 删除传入路径的文件

 @param DirectoryPath 路径
 */
+(void)removeDirectoryPath:(NSString *)DirectoryPath;

+ (NSString *)sizeStr;

@end
