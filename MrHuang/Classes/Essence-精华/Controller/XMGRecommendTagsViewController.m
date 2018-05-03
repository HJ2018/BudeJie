//
//  XMGRecommendTagsViewController.m
//  MrHuang
//
//  Created by MrHuang on 16/5/31.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "XMGRecommendTagsViewController.h"
#import "HJRecommendTagCell.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "XMGRecommendTag.h"
@interface XMGRecommendTagsViewController ()
/** 标签数据 */
@property (nonatomic, strong) NSArray *tags;
@end

static NSString * const XMGTagsId = @"tag";

@implementation XMGRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
    
    
    
}


- (void)loadTags
{
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"加载中"];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.tags = [XMGRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
    
}
- (void)setupTableView
{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HJRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:XMGTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HJGBColor(223, 223, 223);
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    HJRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTagsId];
//    
//    cell.recommendTag = self.tags[indexPath.row];
//    
//    return cell;
//    
    static NSString *HJTageID = @"tag";
    HJRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:HJTageID];
    
    
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
    
}



@end
