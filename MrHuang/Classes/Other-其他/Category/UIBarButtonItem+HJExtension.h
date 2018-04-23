//
//  UIBarButtonItem+HJExtension.h
//  MrHuang
//
//  Created by MrHuang on 16/5/26.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HJExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage targer:(id)target action:(SEL)action;
@end
