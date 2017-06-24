//
//  XMGRecommendTag.h
//  MrHuang
//
//  Created by MrHuang on 16/5/31.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendTag : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end
