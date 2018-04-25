//
//  HJRecommendTagCell.m
//  MrHuang
//
//  Created by MrHuang on 16/5/31.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJRecommendTagCell.h"
#import "XMGRecommendTag.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Antialias.m"


@interface HJRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation HJRecommendTagCell

-(void)setRecommendTag:(XMGRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
//    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list]];
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        
        UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        [path addClip];
        
        [image drawAtPoint:CGPointZero];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        self.imageListImageView.image = image;
        
    }];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
    self.subNumberLabel.text =subNumber;
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
