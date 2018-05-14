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
#import "UIImageView+Download.h"
#import "UIImage+GIF.h"
#import "SeeBigPictureViewController.h"

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

            if (topic.is_gif) {

                NSData *imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:topic.image1]];
                self.imageView.image = [UIImage sd_animatedGIFWithData:imagedata];
                
            }else{
                 [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
            }

        }else if (manager.isReachableViaWWAN){
            
            if (topic.is_gif) {
                
                NSData *imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:topic.image0]];
                self.imageView.image = [UIImage sd_animatedGIFWithData:imagedata];
                
            }else{
               [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0]placeholderImage:placeholder];
            }

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
    
    
    
//    忽略大小写
//    if ([topic.image1.lowercaseString hasSuffix:@"gif"]) {
//
//    }
    
    
    if (topic.isBigPicture) {
        CGFloat imageW = topic.middleFrame.size.width;
        CGFloat imageH = imageW * topic.height / topic.width;
        
        // 开启上下文
        UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
        // 绘制图片到上下文中
        [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
    }
    
    // gif
    self.gifView.hidden = !topic.is_gif;
    
    // 点击查看大图
    if (topic.isBigPicture) { // 超长图
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
    
    
}
- (IBAction)seeBigPicet:(id)sender {
    
    SeeBigPictureViewController *vc = [[SeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

@end
