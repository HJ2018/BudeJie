//
//  HJMeFooterView.m
//  MrHuang
//
//  Created by MrHuang on 16/6/3.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJMeFooterView.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "HJWebViewController.h"
#import "MJExtension.h"
#import "HJMeSquare.h"
#import "HJMeSquareButton.h"

@implementation HJMeFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        [SVProgressHUD showWithStatus:@"加载中"];
        [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            
             [SVProgressHUD dismiss];
            NSArray *squares  =[HJMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            [self createSquares:squares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"请求失败%@",error);
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
        }];
        
    }
    return self;
}

-(void)createSquares:(NSArray *)squares
{
    NSInteger count = squares.count;
    
    NSInteger maxColsCount = 4;
    CGFloat buttonW = self.width/maxColsCount;
    CGFloat buttonH = buttonW;
    for (NSInteger i=0; i<count; i++) {
        HJMeSquareButton *button = [HJMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                                    [self addSubview:button];
        button.x = (i % maxColsCount) * buttonW;
        button.y = (i/maxColsCount)*buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        button.square =squares[i];
    }
    // 设置footer的高度 == 最后一个按钮的bottom(最大Y值)
    self.height = self.subviews.lastObject.bottom;
    
    // 设置tableView的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData]; // 重新刷新数据(会重新计算contentSize)
}
-(void)buttonClick:(HJMeSquareButton *)button
{
    NSString *url = button.square.url;
    if ([url hasPrefix:@"http"]) {
        UITabBarController *taBarVc = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = taBarVc.selectedViewController;
        HJWebViewController *webView = [[HJWebViewController alloc]init];
        webView.url = url;
         webView.navigationItem.title = button.currentTitle;
        nav.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:webView animated:YES];
        
    }
    NSLog(@"ssssss");
}
@end
