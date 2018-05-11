//
//  UIImage+Antialias.m
//  BuDeJie
//
//  Created by yz on 15/10/31.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "UIImage+Antialias.h"

@implementation UIImage (Antialias)
// 在周边加一个边框为1的透明像素
- (UIImage *)imageAntialias
{
    CGFloat border = 1.0f;
    CGRect rect = CGRectMake(border, border, self.size.width-2*border, self.size.height-2*border);
    
    UIImage *img = nil;
    
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    [self drawInRect:CGRectMake(-1, -1, self.size.width, self.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.size);
    [img drawInRect:rect];
    UIImage* antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiImage;
}

+ (UIImage *)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

//把图片裁剪成圆形的
-(instancetype)circleImage
{
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    [path addClip];
    
    [self drawAtPoint:CGPointZero];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


+ (instancetype)xmg_circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}
@end
