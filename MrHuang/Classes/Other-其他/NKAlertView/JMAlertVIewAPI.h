//
//  JMAlertVIewAPI.h
//  Test123
//
//  Created by 寻云网络 on 2019/4/28.
//  Copyright © 2019 寻云网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMAlertVIewAPI : NSObject

/**
 自定义弹框

 @param title 标题
 @param titlecolor 标题颜色
 @param contentitle 内容
 @param ContenTitlecolor 内容颜色
 @param actions 点击按钮文字@["确认"，@"取消"]
 @param color 点击按钮文字颜色
 @param handle 返回事件0取消 1 确认
 */
+(void)AlertViewTitle:(NSString *)title TitleColor:(UIColor *)titlecolor ConetentTitle:(NSString *)contentitle ContentTitleColor:(UIColor *)ContenTitlecolor actions:(NSArray *)actions actionsColor:(NSArray<UIColor *> *)color handle:(void (^)(NSInteger index))handle;

/**
 默认弹框

 @param title 标题
 @param message 内容
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message;


/**
 默认确认回调弹框

 @param title 标题
 @param message 内容
 @param handler 回调事件
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(NSInteger index))handler;

/**
 默认取消确认回调弹框
 
 @param title 标题
 @param message 内容
  @param actions 点击按钮文字@["确认"，@"取消"]
 @param handler 回调事件
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray *)actions handler:(void (^)(NSInteger index))handler;

@end

NS_ASSUME_NONNULL_END
