//
//  UIView+Extended.h
//  HJWEIBO
//
//  Created by 黄杰 on 15/12/9.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Extended)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;


+(instancetype)viewFromxib;
@end
