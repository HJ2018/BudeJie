//
//  UITextField+Text.m
//  MrHuang
//
//  Created by jie.huang on 2018/4/26.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import "UITextField+Text.h"
#import <objc/message.h>

@implementation UITextField (Text)


-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    
    
//    Method setplaceholderColor = class_getInstanceMethod(self, @selector(setPlaceholder:));
//    Method HJsetplaceholderColor = class_getInstanceMethod(self, @selector(HJ_setPlaceholder:));
    
//    method_exchangeImplementations(setplaceholderColor, HJsetplaceholderColor);
    
//    objc_setAssociatedObject(self, @"placeholderLabel", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeholderLable = [self valueForKey:@"placeholderLabel"];
    
    placeholderLable.textColor = placeholderColor;
    
}

-(UIColor *)placeholderColor{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

-(void)HJ_setPlaceholder:(NSString *)placeholder{
    
    self.placeholder = placeholder;
    
//    [self HJ_setPlaceholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}

@end
