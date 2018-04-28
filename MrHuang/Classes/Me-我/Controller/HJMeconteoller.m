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
#import <SafariServices/SafariServices.h>
#import "SDImageCache.h"
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]



static NSString * const ID = @"cell";

@interface HJMeconteoller () <UICollectionViewDataSource,UICollectionViewDelegate,SFSafariViewControllerDelegate>

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
    
    self.tableView.tableFooterView = [[HJMeFooterView alloc]init];
    
    
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
    
//    [self getData];
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
//   CGFloat collectionViewH = ((_dataArr.count - 1)/cols +1) * itemWH;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, collectionViewH) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    collectionView.scrollEnabled = NO;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    [collectionView registerNib:[UINib nibWithNibName:@"HJCollectionCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    
    [collectionView reloadData];
}


#pragma mack - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJMeSquare *item = _dataArr[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    
    NSURL *url = [NSURL URLWithString:item.url];
    
    // SFSafariViewController使用Modal
    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];
  
    [self presentViewController:safariVc animated:YES completion:nil];
    
    
    
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
        cell.textLabel.text = [self sizeStr];
        // 只要有其他cell设置过imageView.image, 其他不显示图片的cell都需要设置imageView.image = nil
        cell.imageView.image = nil;
    }
    
    return cell;
}

//点击cell清楚缓存
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清空缓存
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取cache文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:CachePath error:nil];
    
    for (NSString *subPath in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [CachePath stringByAppendingPathComponent:subPath];
        
        // 删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }
    
    [self.tableView reloadData];
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



// 获取缓存尺寸字符串
- (NSString *)sizeStr
{
    // 获取Caches文件夹路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSInteger totalSize = [self getFileSize:cachePath];
    
    NSString *sizeStr = @"清除缓存";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    
    return sizeStr;
}

// 自己去计算SDWebImage做的缓存
- (NSInteger)getFileSize:(NSString *)directoryPath
{
    // NSFileManager
    // attributesOfItemAtPath:指定文件路径,就能获取文件属性
    // 把所有文件尺寸加起来
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取文件夹下所有的子路径,包含子路径的子路径
    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
    
    NSInteger totalSize = 0;
    
    for (NSString *subPath in subPaths) {
        // 获取文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 判断隐藏文件
        if ([filePath containsString:@".DS"]) continue;
        
        // 判断是否文件夹
        BOOL isDirectory;
        // 判断文件是否存在,并且判断是否是文件夹
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        // 获取文件属性
        // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        
        // 获取文件尺寸
        NSInteger fileSize = [attr fileSize];
        
        totalSize += fileSize;
    }
    
    return totalSize;
    
}
@end
