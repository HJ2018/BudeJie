//
//  UIView+Extended.m
//  HJWEIBO
//
//  Created by 黄杰 on 15/12/9.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import "UIView+Extended.h"


@implementation UIView (Extended)




+(instancetype)viewFromxib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame; 
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)right
{
    //    return self.xmg_x + self.xmg_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)bottom
{
    //    return self.xmg_y + self.xmg_height;
    return CGRectGetMaxY(self.frame);
}

//- (void)setright:(CGFloat)right
//{
//    self.x = right - self.width;
//}
//
//- (void)setbottom:(CGFloat)bottom
//{
//    self.y = bottom - self.height;
//}
-(void)setRight:(CGFloat)right
{
     self.x = right - self.width;
}
-(void)setBottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}
@end
