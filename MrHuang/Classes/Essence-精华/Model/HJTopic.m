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
    
    
    if (self.type != TopicTypeWWord) {
        
        CGFloat middW = textMaxSize.width;
        CGFloat middH = middW * self.height /self.width;
        CGFloat middY = _cellHeight;
        CGFloat middX = 10;
        
        self.middleFrame = CGRectMake(middX, middY, middW+10, middH);
        
        _cellHeight += middH + 10;
        
    }
    
    
    if (self.top_cmt.count) { // 有最热评论
        // 标题
        _cellHeight += 17;
        
        // 内容
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _cellHeight += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + 10;
    }

    _cellHeight += 40;
    return _cellHeight;
}

@end
