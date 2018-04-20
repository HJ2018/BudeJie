//
//  UIButton+HJ.h
//  MrHuang
//
//  Created by jie.huang on 2018/4/20.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TouchedBlock)(NSInteger tag);

@interface UIButton (HJ)


/**
 添加 addtarget
 */
-(void)addActionHandler:(TouchedBlock)touchHandler;

@end
