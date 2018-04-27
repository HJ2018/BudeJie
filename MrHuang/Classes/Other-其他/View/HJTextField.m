//
//  HJTextField.m
//  MrHuang
//
//  Created by jie.huang on 2018/4/26.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import "HJTextField.h"

@implementation HJTextField

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.tintColor = [UIColor  whiteColor];
    /*
     开始编辑
     */
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    /*
     结束编辑
     */
    [self addTarget:self action:@selector(textend) forControlEvents:UIControlEventEditingDidEnd];
    
    
//    通过koc获取占位字符控件
    
    //    UILabel *placeholderLable = [self valueForKey:@"placeholderLabel"];
    //
    //    placeholderLable.textColor = [UIColor whiteColor];
    
     self.placeholderColor = [UIColor lightGrayColor];
    
}

-(void)textBegin{
    
//    第一种方式
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:dict];
    
    //    第二种方式
//    UILabel *placeholderLable = [self valueForKey:@"placeholderLabel"];
//    
//    placeholderLable.textColor = [UIColor whiteColor];
    
    self.placeholderColor = [UIColor whiteColor];
    
}

-(void)textend{
    
//    第一种方式
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:dict];
    
    
        //    第二种方式
//    UILabel *placeholderLable = [self valueForKey:@"placeholderLabel"];
//
//    placeholderLable.textColor = [UIColor lightGrayColor];
    
    
     self.placeholderColor = [UIColor lightGrayColor];
    
}

@end
