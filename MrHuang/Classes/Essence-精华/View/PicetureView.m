//
//  PicetureView.m
//  MrHuang
//
//  Created by jie.huang on 2018/5/10.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import "PicetureView.h"
#import "HJTopic.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

@interface PicetureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@end

@implementation PicetureView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
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
    
    
}

@end
