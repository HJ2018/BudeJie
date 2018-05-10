//
//  HJTopiccell.h
//  MrHuang
//
//  Created by MrHuang on 16/9/18.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJTopic;

@interface HJTopiccell : UITableViewCell

@property (nonatomic , strong)HJTopic *topic;
@property (weak, nonatomic) IBOutlet UIView *topcommentsView;
@property (weak, nonatomic) IBOutlet UILabel *commentsLable;

@end
