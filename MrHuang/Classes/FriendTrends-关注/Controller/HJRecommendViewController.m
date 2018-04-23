//
//  HJRecommendViewController.m
//  MrHuang
//
//  Created by MrHuang on 16/5/26.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "HJRecommendCategory.h"
#import "HJRecommendCategoryCell.h"
#import "HJRecommendUser.h"
#import "HJRecommendUserCell.h"

#define HJSelectedCategory self.categories[self.categoryTableview.indexPathForSelectedRow.row]

@interface HJRecommendViewController ()<UITabBarDelegate,UITableViewDataSource>

/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableview;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation HJRecommendViewController
static NSString *const HJCategoryId = @"category";

static NSString * const HJUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 控件的初始化
    [self setupTableView];
    
    // 加载左侧的类别数据
    [self loadCategories];
    
    // 添加刷新控件
    [self setupRefresh];

    
}
/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    HJRecommendCategory *rc = self.categories[self.categoryTableview.indexPathForSelectedRow.row];
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
}
-(void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}
-(void)loadNewUsers
{
    HJRecommendCategory *rc= self.categories[self.categoryTableview.indexPathForSelectedRow.row];
    // 设置当前页码为1
    rc.currentPage = 1;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
     self.params = params;
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php"parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        
        NSArray *users = [HJRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除所有旧数据
        [rc.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        // 保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        NSLog(@"%@",params);
        NSLog(@"--------%@",self.params);
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
    }];
}

-(void)loadMoreUsers
{
    HJRecommendCategory *category = HJSelectedCategory;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php"parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSArray *users = [HJRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
   
        // 不是最后一次请求
        if (self.params != params) return;
        // 刷新右边的表格
        [self.userTableView reloadData];
 
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
    }];
    

}
-(void)loadCategories
{
    // 发送请求
    [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%@",downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.categories = [HJRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableview reloadData];
        
        // 默认选中首行
        [self.categoryTableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];
}

-(void)setupTableView
{
    [self.categoryTableview registerNib:[UINib nibWithNibName:NSStringFromClass([HJRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:HJCategoryId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HJRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:HJUserId];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableview.contentInset;
    self.userTableView.rowHeight = 70;
    
    
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = HJGBColor(223, 223, 223);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableview) { // 左边的类别表格
        return self.categories.count;
    } else { // 右边的用户表格
        // 左边被选中的类别模型
        HJRecommendCategory *c = self.categories[self.categoryTableview.indexPathForSelectedRow.row];
        return c.users.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableview) { // 左边的类别表格
        HJRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:HJCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        HJRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:HJUserId];
        HJRecommendCategory *c = self.categories[self.categoryTableview.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    HJRecommendCategory *c = self.categories[indexPath.row];
    if (c.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    } else {
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}



@end
