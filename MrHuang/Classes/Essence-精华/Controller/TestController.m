//
//  TestController.m
//  MrHuang
//
//  Created by jie.huang on 30/7/18.
//  Copyright © 2018年 MrHuang. All rights reserved.
//

#import "TestController.h"
#import "HJTitleButton.h"

#import "oneController.h"
#import "TwoController.h"
#import "JINScrollView.h"
//#import "UINavigationController+TZPopGesture.h"
// 屏幕物理宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕物理高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@interface TestController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>


@property (nonatomic, weak) UIButton *selectedTitleButton;

@property (nonatomic, weak) JINScrollView *scrollView;

@property (nonatomic, weak) UIView *titlesView;

@property (nonatomic, strong) NSString *carCode;




@end

@implementation TestController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupChildViewControllers];
    
    [self setupScrollView];
    
    [self setupTitleView];
    
    [self addChildVcView];
    
    self.view.backgroundColor = [UIColor whiteColor];


}


-(void)setupChildViewControllers{
    
    

        
    oneController *N520 = [[oneController alloc]init];
    N520.view.backgroundColor = [UIColor orangeColor];
    [self addChildViewController:N520];
    
    TwoController *Diagnosisvc = [[TwoController alloc]init];
    Diagnosisvc.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:Diagnosisvc];

}




-(void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    JINScrollView *scrollView = [[JINScrollView alloc]init];
    scrollView.delegate =self;
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);
    [self.view addSubview:scrollView];
    self.scrollView= scrollView;



}

-(void)setupTitleView
{
    UIView *titleView = [[UIView alloc]init];
    
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    titleView.layer.borderColor = [UIColor whiteColor].CGColor;
    titleView.layer.cornerRadius = 5;
    titleView.clipsToBounds = YES;
    titleView.layer.borderWidth = 1.0;
    titleView.frame = CGRectMake(self.view.width/2-100, 30, 200, 35);
    //    [self.view addSubview:titleView];
    self.navigationItem.titleView = titleView;
    
    self.titlesView = titleView;
    
    NSArray *titles = @[@"Test1", @"Test2"];
    NSInteger count = titles.count;
    CGFloat titleBUttonw = titleView.width / 2;
    CGFloat titleButttonh = titleView.height;
    for (NSInteger i=0; i<count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setBackgroundImage:[UIImage imageNamed:@"pushguidebg"] forState:UIControlStateSelected];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        titleButton.tag =i;
        [titleButton addTarget:self action:@selector(titClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        titleButton.frame = CGRectMake(i * titleBUttonw, 0, titleBUttonw, titleButttonh);
    }

    HJTitleButton *firstTitleButton = titleView.subviews.firstObject;
    
    [firstTitleButton.titleLabel sizeToFit];
    firstTitleButton.selected= YES;
    self.selectedTitleButton =firstTitleButton;
    
    [self titClick:firstTitleButton];
    
    
    
    
}

-(void)titClick:(HJTitleButton *)titleButton
{
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - 添加子控制器的view
- (void)addChildVcView
{
    if (self.childViewControllers.count != 0) {
        
        NSUInteger index = self.scrollView.contentOffset.x  / self.scrollView.width;
        UIViewController *childVc = self.childViewControllers[index];
//        if ([childVc isViewLoaded]) return;
        childVc.view.frame = self.scrollView.bounds;
        [self.scrollView addSubview:childVc.view];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    HJTitleButton *titleButton = self.titlesView.subviews[index];
    [self titClick:titleButton];
    [self addChildVcView];
    
}



@end
