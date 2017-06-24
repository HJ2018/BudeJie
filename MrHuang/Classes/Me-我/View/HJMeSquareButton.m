//
//  HJMeSquareButton.m
//  MrHuang
//
//  Created by MrHuang on 16/6/3.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJMeSquareButton.h"
#import "HJMeSquare.h"
#import "UIButton+WebCache.h"
@implementation HJMeSquareButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame: frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        self.backgroundColor= [UIColor whiteColor];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.y = self.height*0.15;
    self.imageView.height = self.height*0.5;
    self.imageView.width = self.imageView.height;
    self.imageView.centerX = self.width*0.5;
    
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.bottom;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height-self.titleLabel.y;
    
}

-(void)setSquare:(HJMeSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
}
@end
