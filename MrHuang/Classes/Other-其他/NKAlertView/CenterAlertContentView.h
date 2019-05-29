//
//  CenterAlertContentView.h
//  NKAlertView
//
//  Created by 聂宽 on 2019/3/20.
//  Copyright © 2019 聂宽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CancelBlock)(void);
typedef void(^BackIndex)(NSInteger index);
@interface CenterAlertContentView : UIView

@property(nonatomic, copy,nullable) CancelBlock cance;
@property(nonatomic, copy) BackIndex Back;
@property (nonatomic, strong,nullable) UIColor *TitleColor;
@property (nonatomic, strong,nullable) NSString *Title;
@property (nonatomic, strong,nullable) UIColor *ContentColor;
@property (nonatomic, strong,nullable) NSString *Content;
@property (nonatomic, strong,nullable) NSArray *actionsarry;
@property (nonatomic, strong,nullable) NSArray<UIColor *> *color;
@property (nonatomic, assign) BOOL isOne;
@end

NS_ASSUME_NONNULL_END
