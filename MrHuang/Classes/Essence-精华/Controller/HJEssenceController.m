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
    
    [self addChildVcView];
    

}

-(void)setupChildViewControllers
{
    HJAllViewController *all = [[HJAllViewController alloc]init];
    
    [self addChildViewController:all];
    
    HJVideoViewController *Video = [[HJVideoViewController alloc]init];
    
    [self addChildViewController:Video];
    
    HJVoiceViewController *Voice = [[HJVoiceViewController alloc]init];
    
    [self addChildViewController:Voice];
    
    HJPictureViewController *Picture = [[HJPictureViewController alloc]init];
    
    [self addChildViewController:Picture];
    
    HJWordViewController *Word = [[HJWordViewController alloc]init];
    
    [self addChildViewController:Word];
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
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);
    [self.view addSubview:scrollView];
    self.scrollView= scrollView; 
    
//    NSInteger count = self.childViewControllers.count;
//    for (NSInteger i =0; i<count; i++) {
//        UITableView *childVcView = (UITableView *)self.childViewControllers[i].view;
//        childVcView.backgroundColor = HJRandomColor;
//        childVcView.x = i * childVcView.width;
//        childVcView.y = 0;
//        childVcView.height = scrollView.height;
//        [scrollView addSubview:childVcView];
//
//        // 内边距
//        childVcView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
//        childVcView.scrollIndicatorInsets = childVcView.contentInset;
//    }
//     scrollView.contentSize = CGSizeMake(count * scrollView.width, 0);
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
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.width = titleButton.titleLabel.width;
        self.indicatorView.centerX = titleButton.centerX;
    }];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
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
//jie.huang@timanetworks.com

- (void)tagClick
{
    HJLog(@"点击了");
    XMGRecommendTagsViewController *HJTag= [[XMGRecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:HJTag animated:YES];
}

#pragma mark - 添加子控制器的view
- (void)addChildVcView
{
    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    
    NSLog(@"%ld",(unsigned long)index);
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];

    if ([childVc isViewLoaded]) return;
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

#pragma mark - <UIScrollViewDelegate>


//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{

//    NSInteger index = scrollView.contentOffset.x/scrollView.width;
//    UIViewController *childVc =self.childViewControllers[index];
//    childVc.view.y= 0;
//    childVc.view.x= index * scrollView.width;
//    childVc.view.width = scrollView.width;
//    childVc.view.height = scrollView.height;
//    [scrollView addSubview:childVc.view];
//    [self addChildVcView];
//    
//}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}
/**
 *  人为触发的方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSUInteger index = scrollView.contentOffset.x/scrollView.width;
//    
//    HJTitleButton *titleBUtton = self.titlesView.subviews[index];
//    [self titClick:titleBUtton];
    // 选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    HJTitleButton *titleButton = self.titlesView.subviews[index];
    [self titClick:titleButton];
    
    // 添加子控制器的view
    [self addChildVcView];
    
}

@end
