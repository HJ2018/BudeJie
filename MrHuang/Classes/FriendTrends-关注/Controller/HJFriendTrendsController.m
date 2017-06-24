//
//  HJFriendTrendsController.m
//  HJ百思不得姐
//
//  Created by MrHuang on 16/5/24.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJFriendTrendsController.h"
#import "HJRecommendViewController.h"
#import "HJLoginRegisterViewController.h"
@implementation HJFriendTrendsController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = HJGBColor(223, 223, 223);
}
- (IBAction)loginRegister:(id)sender {
    HJLoginRegisterViewController *Login = [[HJLoginRegisterViewController alloc]init];
    
    [self presentViewController:Login animated:YES completion:nil];
//    [self.navigationController pushViewController:Login animated:YES];
    
    
}

- (void)friendsClick
{
    HJRecommendViewController *vc = [[HJRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}


@end
