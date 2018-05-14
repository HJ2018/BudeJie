//
//  VoiceView.m
//  MrHuang
//
//  Created by jie.huang on 2018/5/10.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import "VoiceView.h"
#import "HJTopic.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "UIImageView+Download.h"
#import "SeeBigPictureViewController.h"

@interface VoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end


@implementation VoiceView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    
     self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

/**
 *  查看大图
 */
- (void)seeBigPicture
{
    SeeBigPictureViewController *vc = [[SeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

-(void)setTopic:(HJTopic *)topic{
    
    _topic = topic;
    
    //    如果有占位图片补上占位图片
    UIImage *placeholder = nil;
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //    通过SDWebImage 取缓存图片 key 就是图片的url
    UIImage *SDimage = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:topic.image1];
    
    if (SDimage) {
        self.imageView.image = SDimage;
    }else{
        if (manager.isReachableViaWiFi) {
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
            
        }else if (manager.isReachableViaWWAN){
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0]placeholderImage:placeholder];
            
        }else{
            //            获取缩略图
            UIImage *thumbnailimage = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:topic.image0];
            if (thumbnailimage) {
                self.imageView.image = thumbnailimage;
            }else{
                //                没有下载任何图片
                self.imageView.image = placeholder;//如果没有占位图片情况循环利用过来的图片
            }
        }
    }
    
    if ( topic.playcount >=10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万",topic.playcount/10000.0];
    }else if (topic.playcount>0){
        self.playcountLabel.text =[NSString stringWithFormat:@"%zd", topic.playcount];
    }
//    %04zd  占据4位 多余的用0 填补
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topic.voicetime/60 ,topic.voicetime%60];
    
}

@end
