//
//  BottomAlertContentView.m
//  NKAlertView
//
//  Created by 聂宽 on 2019/3/20.
//  Copyright © 2019 聂宽. All rights reserved.
//

#import "BottomAlertContentView.h"
#import "NKAlertView.h"

#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BottomAlertContentView ()<UIPickerViewDelegate>
{
    NSArray *_nameArray;
    
}
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSString *ProblemStr;

@end

@implementation BottomAlertContentView

- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
         _nameArray = [NSArray arrayWithObjects:@"您最亲近(家人、朋友)的人的姓名?",@"您最亲近(家人、朋友)的人的生日",@"您最尊敬(老师、领导)的人的姓名",@"您最尊敬(老师、领导)的人的生日",@"您暗恋过的人的姓名",@"您的梦想",@"您最难忘的一件事",@"您的小学名称",@"您的中学名称",@"自定义问题",nil];
        [self addSubview:_pickerView];
    }
    return _pickerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = @"选择问题";
        titleLab.textColor = [UIColor blackColor];
        [self addSubview:titleLab];
        titleLab.frame = CGRectMake(60, 0, CGRectGetWidth(frame) - 120, 50);
        
        self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(titleLab.frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - 100);
        
        UIButton *LeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        LeftBtn.backgroundColor = NKColorWithRGB(0xFED953);
        LeftBtn.tag = 13;
        [LeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [LeftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [LeftBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:LeftBtn];
        LeftBtn.frame = CGRectMake(0, 0,60, 50);
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        rightBtn.backgroundColor = NKColorWithRGB(0xFED953);
        rightBtn.tag = 12;
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(CGRectGetWidth(frame) - 60, 0, 60, 50);
        
        
    }
    return self;
}

- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    if (btn.tag == 12) {
        if (self.backwenti) {
            if (self.ProblemStr.length ==0) {
                self.ProblemStr = _nameArray[0];
            }
             self.backwenti(self.ProblemStr);
        }
    }else{
        if (self.cancerBlock) {
            self.cancerBlock();
        }
    }
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return [_nameArray count];
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 40.0f;
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.ProblemStr = [_nameArray objectAtIndex:row];
}
//显示的标题

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [_nameArray objectAtIndex:row];
}

@end
