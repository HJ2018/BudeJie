//
//  CenterAlertContentView.m
//  NKAlertView
//
//  Created by 聂宽 on 2019/3/20.
//  Copyright © 2019 聂宽. All rights reserved.
//

#import "CenterAlertContentView.h"
#import "NKAlertView.h"

#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CenterAlertContentView ()

@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, weak) UIButton *centerBtn;
@property (nonatomic, weak) UILabel *Label;
@property (nonatomic, weak) UILabel *TitleLabel;

@end
@implementation CenterAlertContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = @"提示";
        titleLab.textColor = [UIColor blackColor];
        [self addSubview:titleLab];
        self.TitleLabel = titleLab;
        titleLab.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 50);
        
        // shop_invite_icon
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        self.Label = label;
        [self addSubview:label];
        label.frame = CGRectMake(20,  CGRectGetMaxY(titleLab.frame) , CGRectGetWidth(frame) - 30, CGRectGetHeight(frame) - (CGRectGetMaxY(titleLab.frame) + 10 + 60));
        
        UIView *botVIew = [[UIView alloc] init];
        botVIew.backgroundColor = NKColorWithRGB(0xEFEFF4);
        [self addSubview:botVIew];
        botVIew.frame = CGRectMake(0, CGRectGetHeight(frame) - 50, CGRectGetWidth(frame), 50);
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.backgroundColor = [UIColor whiteColor];
        leftBtn.tag = 11;
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [botVIew addSubview:leftBtn];
        self.leftBtn = leftBtn;
        leftBtn.frame = CGRectMake(0, 1, (CGRectGetWidth(frame) - 1) * 0.5, 49);
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.backgroundColor = [UIColor whiteColor];
        rightBtn.tag = 12;
        [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [botVIew addSubview:rightBtn];
        self.rightBtn = rightBtn;
        rightBtn.frame = CGRectMake((CGRectGetWidth(frame) - 1) * 0.5 + 1, 1, (CGRectGetWidth(frame) - 1) * 0.5, 49);
        
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        centerBtn.tag = 12;
        [centerBtn setTitle:@"确认" forState:UIControlStateNormal];
        [centerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        centerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [centerBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [botVIew addSubview:centerBtn];
        self.centerBtn  = centerBtn;
        centerBtn.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 49);
        
    }
    return self;
}

-(void)setTitle:(NSString *)Title{
    
    _Title = Title;
    
    if (_Title) {
      self.TitleLabel.text = _Title;
    }else{
      self.TitleLabel.text = @"提示";
    }
}

-(void)setTitleColor:(UIColor *)TitleColor{
    
    _TitleColor = TitleColor;
    
    if (_TitleColor) {
        self.TitleLabel.textColor = _TitleColor;
    }else{
        self.TitleLabel.textColor = [UIColor blackColor];
    }
    
}

-(void)setColor:(NSArray<UIColor *> *)color{
    
    _color = color;
    
    if (_color) {
       
        if (self.isOne) {
            [self.centerBtn setTitleColor:_color[0] forState:(UIControlStateNormal)];
        }else{
            [self.leftBtn setTitleColor:_color[0] forState:(UIControlStateNormal)];
            [self.rightBtn setTitleColor:_color[1] forState:(UIControlStateNormal)];
        }
    }else{
        if (self.isOne) {
            [self.centerBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }else{
            [self.leftBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [self.rightBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
    }
}

-(void)setActionsarry:(NSArray *)actionsarry{
    _actionsarry = actionsarry;
    
    if (_actionsarry) {
      
        if (self.isOne) {
            [self.centerBtn setTitle:actionsarry[0] forState:(UIControlStateNormal)];
        }else{
            [self.leftBtn setTitle:actionsarry[0] forState:(UIControlStateNormal)];
            [self.rightBtn setTitle:actionsarry[1] forState:(UIControlStateNormal)];
        }
    }else{
        if (self.isOne) {
            [self.centerBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        }else{
            [self.leftBtn setTitle:@"取消" forState:(UIControlStateNormal)];
            [self.rightBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        }
    }
    
}


-(void)setContent:(NSString *)Content{
    
    _Content = Content;
    
    self.Label.text = _Content;
    
}
-(void)setContentColor:(UIColor *)ContentColor{
    
    _ContentColor = ContentColor;
    
    if (_ContentColor) {
        self.Label.textColor = _ContentColor;
    }else{
        self.Label.textColor = [UIColor blackColor];
    }
}

-(void)setIsOne:(BOOL)isOne{
    
    _isOne = isOne;
    
    if (self.isOne) {
        _leftBtn.hidden = YES;
        _rightBtn.hidden = YES;
        _centerBtn.hidden = NO;
    }else{
        _leftBtn.hidden = NO;
        _rightBtn.hidden = NO;
        _centerBtn.hidden = YES;
    }
}
- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    if (btn.tag == 11) {
        if (self.Back) {
            self.Back(0);
        }
    }else {
        if (self.cance) {
            self.cance();
        }
        if (self.Back) {
            self.Back(1);
        }
    }
}

@end
