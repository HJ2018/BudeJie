//
//  ADViewController.m
//  MrHuang
//
//  Created by Prince on 2016/12/19.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "ADViewController.h"
#import "HJTabBarController.h"

@interface ADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *adButton;
@property (weak, nonatomic)  UIImageView *adView;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ADViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    

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
