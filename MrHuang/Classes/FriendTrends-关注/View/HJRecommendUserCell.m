
//
//  HJRecommendUserCell.m
//  MrHuang
//
//  Created by MrHuang on 16/5/27.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJRecommendUserCell.h"
#import "HJRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface HJRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end

@implementation HJRecommendUserCell



-(void)setUser:(HJRecommendUser *)user
{
    _user = user;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header]];
    self.screenNameLabel.text = user.screen_name;
    
    NSString *subNumber = nil;
    if (user.fans_count < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = subNumber;
}




@end
