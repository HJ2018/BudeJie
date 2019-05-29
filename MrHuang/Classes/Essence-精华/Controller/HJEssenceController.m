//
//  HJEssenceController.m
//  HJ百思不得姐
//
//  Created by MrHuang on 16/5/24.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJEssenceController.h"
#import "XMGRecommendTagsViewController.h"
#import "HJTitleButton.h"
#import "HJAllViewController.h"
#import "HJVideoViewController.h"
#import "HJVoiceViewController.h"
#import "HJPictureViewController.h"
#import "HJWordViewController.h"

@interface HJEssenceController ()<UIScrollViewDelegate>
/** 当前选中的标题按钮 */
@property (nonatomic, weak) HJTitleButton *selectedTitleButton;
/** 标题按钮底部的指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;


@end

@implementation HJEssenceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupChildViewControllers];
    
    [self setupScrollView];
    
    [self setupTitleView];

    // 添加第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
    

}

-(void)setupChildViewControllers
{
    [self addChildViewController: [[HJAllViewController alloc]init]];
    
    [self addChildViewController:[[HJVideoViewController alloc]init]];

    [self addChildViewController:[[HJVoiceViewController alloc]init]];
    
    [self addChildViewController:[[HJPictureViewController alloc]init]];
    
    [self addChildViewController: [[HJWordViewController alloc]init]];
}

-(void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor=HJRandomColor;
    scrollView.delegate =self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);
    [self.view addSubview:scrollView];
    self.scrollView= scrollView;

}

-(void)setupTitleView
{
    UIView *titleView = [[UIView alloc]init];
    
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    titleView.frame = CGRectMake(0, 64, self.view.width, 35);
    [self.view addSubview:titleView];
    
    self.titlesView = titleView;
    
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = titles.count;
    CGFloat titleBUttonw = titleView.width / 5;
    CGFloat titleButttonh = titleView.height;
    for (NSInteger i=0; i<count; i++) {
        HJTitleButton *titleButton = [HJTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag =i;
        [titleButton addTarget:self action:@selector(titClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        titleButton.frame = CGRectMake(i * titleBUttonw, 0, titleBUttonw, titleButttonh);
    }
    HJTitleButton *firstTitleButton = titleView.subviews.firstObject;
    UIView *indeicatorView = [[UIView alloc]init];
    indeicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indeicatorView.height = 2;
    indeicatorView.y = titleView.height - indeicatorView.height;
    [titleView addSubview:indeicatorView];
    self.indicatorView = indeicatorView;
    
    [firstTitleButton.titleLabel sizeToFit];
    indeicatorView.width =firstTitleButton.titleLabel.width;
    indeicatorView.centerX = firstTitleButton.centerX;
    firstTitleButton.selected= YES;
    self.selectedTitleButton =firstTitleButton;
    
    
}
-(void)titClick:(HJTitleButton *)titleButton
{
    if (self.selectedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:TitleButtonDidRepeatClickNotification object:nil];
    }
    // 处理标题按钮点击
    [self dealTitleButtonClick:titleButton];
}

/**
 *  处理标题按钮点击
 */
- (void)dealTitleButtonClick:(HJTitleButton *)titleButton
{
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.width = titleButton.titleLabel.width;
        self.indicatorView.centerX = titleButton.centerX;
    }completion:^(BOOL finished) {
        // 添加子控制器的view
        [self addChildVcViewIntoScrollView:index];
    }];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
    
    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建，就不用去处理
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == index);
        
        NSLog(@"%d",scrollView.scrollsToTop);
    }
}
-(void)setupNav
{
    // 设置导航栏标题
//    UIButton *button = [[UIButton alloc]init];
//    [button setTitle:@"...." forState:UIControlStateNormal];
    self.navigationItem.titleView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
;
//
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = HJGBColor(223, 223, 223);
}

- (void)tagClick
{
    HJLog(@"点击了");
    XMGRecommendTagsViewController *HJTag= [[XMGRecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:HJTag animated:YES];
}

#pragma mark - <UIScrollViewDelegate>


//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
//    HJTitleButton *titleButton = self.titlesView.subviews[index];
//    [self titClick:titleButton];
//}

/**
 *  人为触发的方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    HJTitleButton *titleButton = self.titlesView.subviews[index];
    
    [self dealTitleButtonClick:titleButton];
    
    
}


#pragma mark - 其他
/**
 *  添加第index个子控制器的view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.scrollView.width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.height);
    // 添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVcView];
}
@end



//tag 值的递归查找
/*
 @implementation UIView
 
 - (UIView *)viewWithTag:(NSInteger)tag
 {
 // 如果自己的tag符合要求，就返回自己
 if (self.tag == tag) return self;
 
 // 遍历子控件（也包括子控件的子控件...），直到找到符合条件的子控件为止
 for (UIView *subview in self.subviews) {
 //        if (subview.tag == tag) return subview;
 UIView *resultView = [subview viewWithTag:tag];
 if (resultView) return resultView;
 }
 
 return nil;
 }
 
 @end
 */


