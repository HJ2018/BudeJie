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

@end
