//
//  HJRefreshHeader.m
//  MrHuang
//
//  Created by MrHuang on 16/9/12.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJRefreshHeader.h"

@interface HJRefreshHeader ()
@property(nonatomic , weak) UIImageView *logo;

@end

@implementation HJRefreshHeader

-(void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;

    self.lastUpdatedTimeLabel.textColor=[UIColor orangeColor];
    self.stateLabel.textColor=[UIColor orangeColor];
    
    UIImageView *logo = [[UIImageView alloc]init];
    
    logo.image = [UIImage imageNamed:@"app_slogan"];
    
    [self addSubview:logo];
    self.logo = logo;
    
}

/**
 *  摆放子控件
 */
-(void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.width = self.width;
    self.logo.height =50;
    self.logo.x = 0;
    self.logo.y = - 80;
    
    self.lastUpdatedTimeLabel.y -= 20;
    self.stateLabel.y -= 20;
    self.arrowView.y -= 20;
}



@end
