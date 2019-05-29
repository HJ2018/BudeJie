//
//  UIButton+Extensions.m
//  峰哥cells
//
//  Created by silence on 2017/9/3.
//  Copyright © 2017年 silence. All rights reserved.
//

// 按钮默认状态 图片在左,文字在右
////////////////////////////////
//  left      | right        ///
//  imageView | titleLable   ///
////////////////////////////////

#import "UIButton+Extensions.h"

@implementation UIButton (Extensions)

/**
 上部分是图片，下部分是文字
 
 @param space 间距
 */
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // titleLabel的宽度不一定正确的时候，需要进行判断
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    if (titleSize.width < labelWidth) {
        titleSize.width = labelWidth;
    }
    
    // 文字距上边框的距离增加imageView的高度+间距，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height+space, -imageSize.width, -space, 0.0)];
    
    // 图片距右边框的距离减少图片的宽度，距离上面的间隔，其它不变
    [self setImageEdgeInsets:UIEdgeInsetsMake(-space, 0.0,0.0,-titleSize.width)];
}

/**
 左边是文字，右边是图片（和原来的样式翻过来）
 
 @param space 间距
 */
- (void)setLeftTitleAndRightImageWithSpace:(CGFloat)space{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;

    // titleLabel的宽度不一定正确的时候，需要进行判断
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    if (titleSize.width < labelWidth) {
        titleSize.width = labelWidth;
    }
    
    // 文字距左边框的距离减少imageView的宽度-间距，右侧增加距离imageView的宽度
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -imageSize.width - space, 0.0, imageSize.width)];
    
    // 图片距左边框的距离增加titleLable的宽度,距右边框的距离减少titleLable的宽度
    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, titleSize.width,0.0,-titleSize.width)];
}

/**
 设置角标的个数（右上角）
 
 @param badgeValue <#badgeValue description#>
 */
- (void)setBadgeValue:(NSInteger)badgeValue{
    
    CGFloat badgeW   = 20;
    CGSize imageSize = self.imageView.frame.size;
    CGFloat imageX   = self.imageView.frame.origin.x;
    CGFloat imageY   = self.imageView.frame.origin.y;
    
    UILabel *badgeLable = [[UILabel alloc]init];
    badgeLable.text = [NSString stringWithFormat:@"%ld",badgeValue];
    badgeLable.textAlignment = NSTextAlignmentCenter;
    badgeLable.textColor = [UIColor whiteColor];
    badgeLable.font = [UIFont systemFontOfSize:12];
    badgeLable.layer.cornerRadius = badgeW*0.5;
    badgeLable.clipsToBounds = YES;
    badgeLable.backgroundColor = [UIColor redColor];
    
    CGFloat badgeX = imageX + imageSize.width - badgeW*0.5;
    CGFloat badgeY = imageY - badgeW*0.25;
    badgeLable.frame = CGRectMake(badgeX, badgeY, badgeW, badgeW);
    [self addSubview:badgeLable];
}

@end
