//
//  UIBarButtonItem+HJExtension.m
//  MrHuang
//
//  Created by MrHuang on 16/5/26.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "UIBarButtonItem+HJExtension.h"

@implementation UIBarButtonItem (HJExtension)


+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage targer:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
