//
//  SeeBigPictureViewController.m
//  MrHuang
//
//  Created by jie.huang on 2018/5/11.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import "SeeBigPictureViewController.h"
#import "HJTopic.h"
#import "UIImageView+WebCache.h"
@interface SeeBigPictureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation SeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //    scrollView.frame = self.view.bounds;
    //    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.saveButton.enabled = YES;
    }];
    imageView.width = scrollView.width;
    imageView.height = imageView.width * self.topic.height / self.topic.width;
    imageView.x = 0;
    if (imageView.height > BSScreenH) { // 超过一个屏幕
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    } else {
        imageView.centerY = scrollView.height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片缩放
    CGFloat maxScale = self.topic.width / imageView.width;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtn:(id)sender {
}


@end
