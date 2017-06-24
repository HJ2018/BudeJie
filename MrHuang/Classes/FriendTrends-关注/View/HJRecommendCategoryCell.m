//
//  HJRecommendCategoryCell.m
//  MrHuang
//
//  Created by MrHuang on 16/5/26.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJRecommendCategoryCell.h"
#import "HJRecommendCategory.h"

@interface HJRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end
@implementation HJRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCategory:(HJRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height-2*self.textLabel.y;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : HJGBColor(78, 78, 78);

}

@end
