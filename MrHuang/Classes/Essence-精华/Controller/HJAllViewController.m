//
//  HJAllViewController.m
//  MrHuang
//
//  Created by MrHuang on 16/6/30.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJAllViewController.h"
#import "AFNetworking.h"
#import "HJTopic.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "HJRefreshHeader.h"
#import "HJTopiccell.h"

@interface HJAllViewController ()

/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<HJTopic *> *topics;

@property (nonatomic, copy) NSString *maxtime;


@end

@implementation HJAllViewController

{
    BOOL isref;
}

//重用标示
static  NSString * const HJTopicId = @"topic";

- (void)viewDidLoad {
    [super viewDidLoad];

   
    [self setupRefresh];
    
    [self setuptable];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:TitleButtonDidRepeatClickNotification object:nil];
    

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)titleButtonDidRepeatClick
{
    [self setupRefresh];
}



-(void)setuptable
{
    
     self.tableView.rowHeight = 300;
    
    self.tableView.backgroundColor = HJCommonBgColor;
    
//    去掉tableview的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
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
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    
    
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [HJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

-(void)loadMoreTopics
{
    
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    
    NSLog(@"%@",params);
    [[AFHTTPSessionManager manager]GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [responseObject writeToFile:@"/Users/huangjie/Desktop/HJresponse.plist" atomically:YES ];
        
        self.maxtime = responseObject[@"info"][@"maxtime"];

        
        NSArray *moreTopics = [HJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.topics.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HJTopiccell *cell = [self.tableView dequeueReusableCellWithIdentifier:HJTopicId];
    
    cell.topic =  self.topics[indexPath.row];
    return cell;
    
}



@end
