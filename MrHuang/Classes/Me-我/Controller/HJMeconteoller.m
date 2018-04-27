//
//  HJMeconteoller.m
//  HJ百思不得姐
//
//  Created by MrHuang on 16/5/24.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJMeconteoller.h"
#import "HJCell.h"
#import "HJMeFooterView.h"
#import "HJSettingViewController.h"
#import "HJCollectionCell.h"
#import "XMGSessionManager.h"
#import "MJExtension.h"
#import "HJMeSquare.h"
#import "UIImageView+WebCache.h"
#import "XMGConst.h"


static NSString * const ID = @"cell";

@interface HJMeconteoller () <UICollectionViewDataSource>

@property(nonatomic ,strong)NSArray *dataArr;

@property(nonatomic ,weak)UICollectionView *collectionView;

@property(nonatomic ,weak)UICollectionViewFlowLayout *layout;

@end


@implementation HJMeconteoller


-(instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.tableFooterView = [[HJMeFooterView alloc]init];
    
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(10 - 35, 0, 0, 0);
    
    
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    // 设置背景色
    self.view.backgroundColor = HJGBColor(223, 223, 223);
    
    [self getData];
}


-(void)getData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    [[XMGSessionManager new]request:RequestTypeGet urlStr:URL_ME parameter:params resultBlock:^(id responseObject, NSError *error) {
        _dataArr =[HJMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        [self seeFootView];
        
        
    }];
    
}


-(void)seeFootView{
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    CGFloat itemWH = (BSScreenW - (cols - 1) * margin) / cols;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    CGFloat collectionViewH =(itemWH + 1) * (_dataArr.count%cols == 0 ? _dataArr.count/cols : _dataArr.count/cols + 1);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, collectionViewH) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    collectionView.scrollEnabled = NO;
    
    collectionView.dataSource = self;
    
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    [collectionView registerNib:[UINib nibWithNibName:@"HJCollectionCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    
    [collectionView reloadData];
}


#pragma mack - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    HJCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    HJMeSquare *data = _dataArr[indexPath.row];
    
    [cell.collImage sd_setImageWithURL:[NSURL URLWithString:data.icon]];
    cell.collLable.text = data.name;
    
    return cell;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"me";
    
    // 2.从缓存池中取
    HJCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[HJCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 4.设置数据
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    } else {
        cell.textLabel.text = @"离线下载";
        // 只要有其他cell设置过imageView.image, 其他不显示图片的cell都需要设置imageView.image = nil
        cell.imageView.image = nil;
    }
    
    return cell;
}

- (void)settingClick
{
    HJLog(@"333");
    HJSettingViewController *setting = [[HJSettingViewController alloc]init];
    
    setting.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)moonClick
{
    HJLog(@"444");
}
@end
