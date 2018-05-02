//
//  ADViewController.m
//  MrHuang
//
//  Created by Prince on 2016/12/19.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "ADViewController.h"
#import "HJTabBarController.h"
#import "AFNetworking.h"
#import "XMGADItem.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "YYHttpTool.h"
#import "XMGSessionManager.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface ADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *adButton;
@property (weak, nonatomic)  UIImageView *adView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) XMGADItem *item;

@end

@implementation ADViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self setUpBG];
    
    [self loadAdData];

    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];
    
}
- (void)timeChange:(id)timer
{
    static int i = 3;
    
    NSString *str = [NSString stringWithFormat:@" 跳过（%d）",i];
    [_adButton setTitle:str forState:UIControlStateNormal];
    
    if (i < 0) { // 3秒，销毁当前界面和定时器
        
        [self jump:nil];
    }
    
    i--;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


- (IBAction)jump:(id)sender {
    
    [_timer invalidate];
    
    HJTabBarController *tabBarVc = [[HJTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
}

- (UIImageView *)adView
{
    if (_adView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        
        [self.view insertSubview:imageV aboveSubview:self.bgView];
        
        _adView = imageV;
    }
    return _adView;
}

#pragma mark - 加载广告数据
- (void)loadAdData
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    [[XMGSessionManager new] request:RequestTypeGet urlStr:URL_GG parameter:parameters resultBlock:^(id responseObject, NSError *error) {
        
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        
        _item = [XMGADItem mj_objectWithKeyValues:adDict];
        
//        CGFloat h = BSScreenW / _item.w * _item.h;
        
        self.adView.frame = CGRectMake(0, 0, BSScreenW, BSScreenH);
        
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
    }];
   
    
//    [YYHttpTool get:URL_GG params:parameters success:^(id responseObj) {
//
//        NSDictionary *adDict = [responseObj[@"ad"] lastObject];
//
//        _item = [XMGADItem mj_objectWithKeyValues:adDict];
//
//        CGFloat h = BSScreenW / _item.w * _item.h;
//
//        self.adView.frame = CGRectMake(0, 0, BSScreenW, h);
//
//        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
//
//    } failure:^(NSError *error) {
//
//          NSLog(@"%@",error);
//
//    }];
    
    
    
    
    
    
    
    
}


- (void)setUpBG
{
    // 6p : 736 6 : 667  5 : 568  4 : 480
    if (iPhone6P) {
        
        _bgView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
        
    }else if (iPhone6){
        
        _bgView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
        
    }else if (iPhone5){
        
        _bgView.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
        
    }else if(iPhone4){
        
        _bgView.image = [UIImage imageNamed:@"LaunchImage-700"];
        
    }
    
}


@end
