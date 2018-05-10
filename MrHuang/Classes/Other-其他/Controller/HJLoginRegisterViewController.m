//
//  HJLoginRegisterViewController.m
//  MrHuang
//
//  Created by MrHuang on 16/6/1.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJLoginRegisterViewController.h"

@interface HJLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *logView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingView;

@end

@implementation HJLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (IBAction)click:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)qiehuanBtn:(id)sender {
    
  
    _leadingView.constant = _leadingView.constant == 0 ? -self.view.frame.size.width : 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.view layoutIfNeeded];
    }];

    
}
//自定义弹窗
- (void)showMessageWithText:(NSString *)text{
    UILabel *alertLabel = [[UILabel alloc] init];
    alertLabel.font = [UIFont systemFontOfSize:15];
    alertLabel.text = text;
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.layer.masksToBounds = YES;
    alertLabel.textColor = [UIColor whiteColor];
    alertLabel.bounds = CGRectMake(0, 0, 100, 80);
    alertLabel.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    alertLabel.backgroundColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:1.0];
    alertLabel.layer.cornerRadius = 10.0f;
    [[UIApplication sharedApplication].keyWindow addSubview:alertLabel];
    
    [UIView animateWithDuration:5 animations:^{
        alertLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [alertLabel removeFromSuperview];
    }];
}


@end
