//
//  HJWebViewController.m
//  MrHuang
//
//  Created by MrHuang on 16/6/3.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJWebViewController.h"


@interface HJWebViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;


//@property (strong, nonatomic) IBOutlet UIToolbar *backItem;
//@property (strong, nonatomic) IBOutlet UIToolbar *forwardItem;

@end

@implementation HJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}



@end
