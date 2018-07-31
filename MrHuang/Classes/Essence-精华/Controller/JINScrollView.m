//
//  JINScrollView.m
//  MrHuang
//
//  Created by jie.huang on 31/7/18.
//  Copyright © 2018年 MrHuang. All rights reserved.
//
//

#import "JINScrollView.h"

@implementation JINScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    
//    if ([self panBack:gestureRecognizer]) {
//        return YES;
//    }
//    return NO;
//    
//}
//
//
//- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
//    
//    if (gestureRecognizer == self.panGestureRecognizer) {
//        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
//        CGPoint point = [pan translationInView:self];
//        UIGestureRecognizerState state = gestureRecognizer.state;
//        if (UIGestureRecognizerStateBegan == state || UIGestureRecognizerStatePossible == state) {
//            CGPoint location = [gestureRecognizer locationInView:self];
//            if (point.x <= 0 && location.x <= 0 && self.contentOffset.x <= 0) {
//                return YES;
//                }
//            }
//        }
//                return NO;
//                
//}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
