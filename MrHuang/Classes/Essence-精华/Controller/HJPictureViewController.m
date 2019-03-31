//
//  HJPictureViewController.m
//  MrHuang
//
//  Created by MrHuang on 16/6/30.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJPictureViewController.h"
#import "AFNetworking.h"
#import "HJTopic.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "HJRefreshHeader.h"
#import "HJTopiccell.h"

@interface HJPictureViewController ()

/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<HJTopic *> *topics;

/** 刷新页数 */
@property (nonatomic, copy) NSString *maxtime;

@end

@implementation HJPictureViewController

//重用标示
static  NSString * const HJTopicId = @"topic";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    
    [self setuptable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:TitleButtonDidRepeatClickNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:XMGTabBarButtonDidRepeatClickNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
    
}

- (void)tabBarButtonDidRepeatClick
{
    
    [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    // 重复点击的不是精华按钮
    if (self.view.window == nil) return;
    
    if (self.tableView.scrollsToTop == NO) return;
    
    [self setupRefresh];
    
    HJLog(@"%@ 2222- 刷新数据", self.class);
}


-(void)setuptable
{
    
    //     self.tableView.rowHeight = 300;
    
    self.tableView.backgroundColor = HJCommonBgColor;
    
    //    去掉tableview的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //    self.tableView.estimatedRowHeight = 200;
    
    //    注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HJTopiccell class]) bundle:nil] forCellReuseIdentifier:HJTopicId];
}

#pragma mark - 刷新控件

-(void)setupRefresh
{
    if ([self.tableView.mj_header isRefreshing]) return;
    
    self.tableView.mj_header = [HJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

#pragma mark - 数据加载

-(void)loadNewTopics
{
    
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    
    [params setObject:@"list" forKey:@"a"];
    [params setObject:@"data" forKey:@"c"];
    [params setObject:@10 forKey:@"type"];
    
    [[XMGSessionManager sharedInstance]request:RequestTypeGet urlStr:CommonURL parameter:params resultBlock:^(id responseObject, NSError *error) {
        
        NSLog(@"%@",responseObject);
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [HJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)loadMoreTopics
{
    
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    
    [params setObject:@"list" forKey:@"a"];
    [params setObject:@"data" forKey:@"c"];
    [params setObject:@10 forKey:@"type"];
    [params setObject:self.maxtime forKey:@"maxtime"];
    
    [[XMGSessionManager sharedInstance]request:RequestTypeGet urlStr:CommonURL parameter:params resultBlock:^(id responseObject, NSError *error) {
        
        
        NSLog(@"%@",responseObject);
        
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *moreTopics = [HJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    }];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 清除缓存
    [[SDImageCache sharedImageCache] clearMemory];
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    // 清除缓存
//    [[SDImageCache sharedImageCache] clearMemory];
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    HJTopic *topic = self.topics[indexPath.row];
    
    return self.topics[indexPath.row].cellHeight;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HJTopiccell *cell = [self.tableView dequeueReusableCellWithIdentifier:HJTopicId];
    
    cell.topic =  self.topics[indexPath.row];
    
    return cell;
    
}


@end
