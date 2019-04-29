//
//  JMAlertVIewAPI.m
//  Test123
//
//  Created by 寻云网络 on 2019/4/28.
//  Copyright © 2019 寻云网络. All rights reserved.
//

#import "JMAlertVIewAPI.h"
#import "NKAlertView.h"
#import "BottomAlertContentView.h"
#import "CenterAlertContentView.h"

#define JMWeakSelf __weak typeof(self) weakSelf = self;
@implementation JMAlertVIewAPI



+(void)AlertViewTitle:(NSString *)title TitleColor:(UIColor *) titlecolor ConetentTitle:(NSString *)contentitle ContentTitleColor:(UIColor *)ContenTitlecolor actions:(NSArray *)actions actionsColor:(NSArray<UIColor *> *)color handle:(void (^)(NSInteger index))handle{
    
    NKAlertView *alertView = [[NKAlertView alloc] init];
    CenterAlertContentView *customContentView = [[CenterAlertContentView alloc] initWithFrame:CGRectMake(0, 0, 281, 180)];
    if (actions.count == 1) {
       customContentView.isOne = YES;
    }else{
        customContentView.isOne = NO;
    }
    customContentView.actionsarry = actions;
    customContentView.TitleColor = titlecolor;
    customContentView.ContentColor = ContenTitlecolor;
    customContentView.Title = title;
    customContentView.Content = contentitle;
    customContentView.color = color;
    customContentView.Back = ^(NSInteger index) {
        if (handle) {
            handle(index);
        }
    };
    alertView.contentView = customContentView;
    [alertView show];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message{
    
    NKAlertView *alertView = [[NKAlertView alloc] init];
    CenterAlertContentView *customContentView = [[CenterAlertContentView alloc] initWithFrame:CGRectMake(0, 0, 281, 180)];
    customContentView.isOne = YES;
    customContentView.actionsarry = nil;
    customContentView.TitleColor = nil;
    customContentView.ContentColor = nil;
    customContentView.Title = title;
    customContentView.Content = message;
    customContentView.color = nil;
    alertView.contentView = customContentView;
    [alertView show];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(NSInteger index))handler{
    
    NKAlertView *alertView = [[NKAlertView alloc] init];
    CenterAlertContentView *customContentView = [[CenterAlertContentView alloc] initWithFrame:CGRectMake(0, 0, 281, 180)];
    customContentView.isOne = YES;
    customContentView.actionsarry = nil;
    customContentView.TitleColor = nil;
    customContentView.ContentColor = nil;
    customContentView.Title = title;
    customContentView.Content = message;
//    customContentView.color = nil;
    customContentView.Back = ^(NSInteger index) {
        if (handler) {
            handler(index);
        }
    };
    alertView.contentView = customContentView;
    [alertView show];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray *)actions handler:(void (^)(NSInteger index))handler{
    
    NKAlertView *alertView = [[NKAlertView alloc] init];
    CenterAlertContentView *customContentView = [[CenterAlertContentView alloc] initWithFrame:CGRectMake(0, 0, 281, [self sizeWithMaxHeig:message])];
    customContentView.isOne = NO;
    customContentView.actionsarry = actions;
    customContentView.TitleColor = nil;
    customContentView.ContentColor = nil;
    customContentView.Title = title;
    customContentView.Content = message;
    customContentView.color = @[[UIColor redColor],[UIColor purpleColor]];
    customContentView.Back = ^(NSInteger index) {
        if (handler) {
            handler(index);
        }
    };
    alertView.contentView = customContentView;
    [alertView show];
}


+(CGFloat)sizeWithMaxHeig:(NSString *)str{
    
    
    CGFloat heig = 0;
    CGSize textMaxSize = CGSizeMake(240, MAXFLOAT);
    
    CGSize size = [str boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
    heig += size.height;
    heig += 125;
     return heig;
}
@end
