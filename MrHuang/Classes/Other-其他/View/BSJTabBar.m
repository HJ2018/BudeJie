//
//  BSJTabBar.m
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/5/11.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "BSJTabBar.h"
#import "UIButton+HJ.h"

@interface BSJTabBar ()

@property (weak, nonatomic) UIButton *publishBtn;


/** 上一次点击的按钮 */
@property (nonatomic, weak) UIControl *previousClickedTabBarButton;
@end

@implementation BSJTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemWidth = self.width / (self.items.count + 1);
    
    
    NSMutableArray<UIView *> *tabBarButtonMutableArray = [NSMutableArray array];
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [tabBarButtonMutableArray addObject:obj];
            obj.width = itemWidth;
        }
        
    }];
    

    [tabBarButtonMutableArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0 && self.previousClickedTabBarButton == nil) {
            self.previousClickedTabBarButton = (id)obj;
        }
        
        [(id)obj addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        obj.x = idx * itemWidth;
        
        if (idx > 1) {
            obj.x = (idx + 1) * itemWidth;
        }
        
        if (idx == 2) {
            [self.publishBtn sizeToFit];
            self.publishBtn.centerX = self.width * 0.5;
            self.publishBtn.y = 0;
//            self.publishBtn.lmj_size = CGSizeMake(itemWidth, itemWidth);
        }
        
        
    }];
    
    [self bringSubviewToFront:self.publishBtn];
}


- (UIButton *)publishBtn
{
    if(_publishBtn == nil)
    {
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        
        _publishBtn = btn;
        
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        LMJWeakSelf(self);
        LMJWeakSelf(btn);
        [btn addActionHandler:^(NSInteger tag) {
            
            !weakself.publishBtnClick ?: weakself.publishBtnClick(weakself, weakbtn);
        }];
        
    }
    return _publishBtn;
}

- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    if (self.previousClickedTabBarButton == tabBarButton) {
        // 发出通知，告知外界tabBarButton被重复点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:XMGTabBarButtonDidRepeatClickNotification object:nil];
    }
    
    self.previousClickedTabBarButton = tabBarButton;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    
//    if ([self pointInside:point withEvent:event] &&  CGRectContainsPoint(self.publishBtn.frame, point)) {
//        
//        return self.publishBtn;
//        
//    }
//    
//    return [super hitTest:point withEvent:event];
//        
//        
//}


@end








