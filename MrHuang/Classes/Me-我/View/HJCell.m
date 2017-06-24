//
//  HJCell.m
//  MrHuang
//
//  Created by MrHuang on 16/6/2.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJCell.h"

@implementation HJCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
/*     跟换系统自带的箭头
 */
        //        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}
/**
 *  从新布局
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil)return;
    
    self.imageView.y = 5;
    self.imageView.height = self.height-10;
    self.imageView.width = self.imageView.height;
    
//    self.textLabel.x = self.imageView.right + 10;
}

@end
