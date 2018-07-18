//
//  HJTabBarController.m
//  HJ百思不得姐
//
//  Created by MrHuang on 16/5/24.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJTabBarController.h"
#import "HJEssenceController.h"
#import "HJNewConteroller.h"
#import "HJFriendTrendsController.h"
#import "HJMeconteoller.h"
#import "HJTabBar.h"
#import "HJNavigationController.h"
#import "BSJTabBar.h"
@implementation HJTabBarController


+(void)load
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
//    UITabBarItem *item = [UITabBarItem appearance];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChilvc:[[HJEssenceController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    [self addChilvc:[[HJNewConteroller alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
    [self addChilvc:[[HJFriendTrendsController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    [self addChilvc:[[HJMeconteoller alloc]init] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    
    
     BSJTabBar *tabBar = [[BSJTabBar alloc] init];
    
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    [tabBar setPublishBtnClick:^(BSJTabBar *tabBar, UIButton *publishBtn) {
        
        NSLog(@"-----");
        
    }];
    
    

}
-(void)addChilvc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage;
{
    
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];

    HJNavigationController *nav = [[HJNavigationController alloc]initWithRootViewController:vc];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
        [self addChildViewController:nav];
    
}

@end
