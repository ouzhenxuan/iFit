//
//  ZXBaseMemberCenterViewController.m
//  TopHot
//
//  Created by Liushannoon on 16/5/3.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import "ZXBaseMemberCenterViewController.h"

/**
 *  cell的重用ID
 */
static NSString *const cellID = @"baseMemberCenterCellID";

@interface ZXBaseMemberCenterViewController ()

@end

@implementation ZXBaseMemberCenterViewController

#pragma mark    -   懒加载

/** 懒加载成员属性 */
- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    
    return _groups;
}

/**
 *  懒加载成员属性
 */
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
//        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//        _tableView = tableView;
//        tableView.delegate = self;
//        tableView.dataSource = self;
//        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

#pragma mark    -   视图

- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[ZXMemberCenterCell class] forCellReuseIdentifier:cellID];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark    -   UITableViewDelegate UITableViewDatasource
/**
 *  返回分组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

/**
 *  返回每组的cell数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZXMemberCenterCellGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXMemberCenterCellGroup *group = self.groups[indexPath.section];
    ZXMemberCenterCellItem *item = group.items[indexPath.row];
    ZXMemberCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.cellItem = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (kEhangCellHeight);
}

/**
 *  返回头部标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZXMemberCenterCellGroup *group = self.groups[section];
    
    return group.headerTitle;
}

/**
 *  返回尾部标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZXMemberCenterCellGroup *group = self.groups[section];
    return group.footerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出哪一组
    ZXMemberCenterCellGroup *group = self.groups[indexPath.section];
    
    // 取出哪一行
    ZXMemberCenterCellItem *item = group.items[indexPath.row];
    
    if (item.itemOpertion) {
        item.itemOpertion(indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return zx_scaleInY_iPhone6(32.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

@end
