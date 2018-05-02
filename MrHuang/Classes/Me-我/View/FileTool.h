//
//  FileTool.h
//  MrHuang
//
//  Created by jie.huang on 2018/4/28.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject


/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹路径
 *
 *  @return 返回文件夹尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;


/**
 *  删除文件夹所有文件
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;


@end
