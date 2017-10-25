//
//  FootTableView.m
//  iFit
//
//  Created by 区振轩 on 2017/10/10.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "FootTableView.h"
#import "FootCategoryModel.h"
#import "FootTableViewCell.h"
#import "FootModel.h"
#import "FootHeaderView.h"

@interface FootTableView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray * footCategoryArray;
@end

@implementation FootTableView


- (instancetype)init{
    if (self == [super init]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        [self setUpTheDate];
    }
    
    return self;
}

- (void)setUpTheDate{
    
    _footCategoryArray = [NSMutableArray array];
    
    FootModel * model = [[FootModel alloc] initModelWithCalorie:100 fat:100];
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:model];
    
    FootCategoryModel * breakfast = [[FootCategoryModel alloc] initModelWithUrl:@"breakfast" title:@"早餐" suggest:@"建议280~370千卡" footArray:array];
    [_footCategoryArray addObject:breakfast];
    
    FootCategoryModel * lunch = [[FootCategoryModel alloc] initModelWithUrl:@"lunch" title:@"午餐" suggest:@"建议440~600千卡" footArray:array];
    [_footCategoryArray addObject:lunch];
    
    FootCategoryModel * dinner = [[FootCategoryModel alloc] initModelWithUrl:@"dinner.png" title:@"晚餐" suggest:@"建议330~450千卡" footArray:array];
    [_footCategoryArray addObject:dinner];
    
    FootCategoryModel * water = [[FootCategoryModel alloc] initModelWithUrl:@"snack.png" title:@"水" suggest:@"8杯" footArray:array];
    [_footCategoryArray addObject:water];
    
}


- (void)registerTheTableViewHeight:(void(^)(double height))block{
    heightReflashBlock = nil;
    heightReflashBlock = [block copy];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    int footCount = 0;
    for (FootCategoryModel * model  in _footCategoryArray) {
        footCount = model.footArray.count + footCount;
    }
    
    double tableViewHeight = 64 * _footCategoryArray.count + 64 * footCount;
    
    heightReflashBlock(tableViewHeight);
}

#pragma tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 64;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {


    FootTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FootTableViewCell" owner:nil options:nil] lastObject];
        //这里需要注意的是为什么是lastObject 应为该Xib中只有一个元素
        
        FootCategoryModel * model = _footCategoryArray[indexPath.section];
        FootModel * footModel = model.footArray[indexPath.row];
        cell.title.text = [NSString stringWithFormat:@"calorie is %f",footModel.calorie];
        cell.suggestLabel.text = [NSString stringWithFormat:@"fat is %f",footModel.calorie];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FootCategoryModel * model = _footCategoryArray[section];
    
    FootHeaderView * headerView = [[[NSBundle mainBundle] loadNibNamed:@"FootHeaderView" owner:nil options:nil] lastObject];
    
    headerView.title.text = model.title;
    headerView.suggestLabel.text = model.suggest;
    headerView.cellImage.image = [UIImage imageNamed:model.url];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _footCategoryArray.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FootCategoryModel * model = _footCategoryArray[section];
    return model.footArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
}

#pragma ---

@end
