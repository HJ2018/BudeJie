//
//  HJTopic.m
//  MrHuang
//
//  Created by MrHuang on 16/9/6.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJTopic.h"

@implementation HJTopic


-(CGFloat)cellHeight{
    
    
    if (_cellHeight) return _cellHeight;
        
    _cellHeight += 60;
    
    CGSize textMaxSize = CGSizeMake(BSScreenW - 40, MAXFLOAT);
    
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + 10;

    _cellHeight += 80;
    return _cellHeight;
}

@end
