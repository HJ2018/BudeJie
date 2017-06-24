//
//  HJQuickLoginButton.m
//  MrHuang
//
//  Created by MrHuang on 16/6/1.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJQuickLoginButton.h"

@implementation HJQuickLoginButton


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.y = 0;
    self.imageView.centerX =self.width/2;
    
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.bottom;
    self.titleLabel.height = self.height-self.titleLabel.y;
    self.titleLabel.width = self.width;
}

@end
