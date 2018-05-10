//
//  HJTopiccell.m
//  MrHuang
//
//  Created by MrHuang on 16/9/18.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJTopiccell.h"
#import "HJTopic.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Antialias.h"

@interface HJTopiccell ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *createdAtLable;
@property (strong, nonatomic) IBOutlet UILabel *text_lable;
@property (strong, nonatomic) IBOutlet UIButton *dingButton;
@property (strong, nonatomic) IBOutlet UIButton *caiButton;
@property (strong, nonatomic) IBOutlet UIButton *repostButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;



@property (strong, nonatomic) IBOutlet UIView *topCmtView;
@property (strong, nonatomic) IBOutlet UILabel *topCmtContentLable;

@end

@implementation HJTopiccell
- (IBAction)more:(id)sender {
    
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"我的标题" message:@"消息内容" preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}


-(void)awakeFromNib
{
    
    [super awakeFromNib];
    //设置tableviewcell的背景图片
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
}
//set 赋值
-(void)setTopic:(HJTopic *)topic
{
    _topic = topic;
    
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (!image) return ;

        self.profileImageView.image = [image circleImage];
        
    }];
    self.nameLable.text = topic.name;
    
    self.createdAtLable.text = topic.created_at;
    
    self.text_lable.text = topic.text;
    
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    
    if (topic.top_cmt.count) {
        self.topcommentsView.hidden = NO;
    }else{
         self.topcommentsView.hidden = YES;
    }
}


-(void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if ( number >=10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/10000.0] forState:UIControlStateNormal];
    }else if (number>0)
    {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}


//重写cell的frame
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 10;
    
    [super setFrame:frame];
}



@end
