//
//  HJVoiceViewController.m
//  MrHuang
//
//  Created by MrHuang on 16/6/30.
//  Copyright © 2016年 MrHuang. All rights reserved.
//

#import "HJVoiceViewController.h"

@interface HJVoiceViewController ()

@end

@implementation HJVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = HJRandomColor;
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@" %@ --%ld",[self class],(long)indexPath.row];
    
    
    return cell;
    
}

@end
