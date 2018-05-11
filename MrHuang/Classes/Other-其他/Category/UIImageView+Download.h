//
//  UIImageView+Download.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"


@interface UIImageView (Download)


- (void)xmg_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock;


//设置圆形图像
- (void)xmg_setHeader:(NSString *)headerUrl;
@end
