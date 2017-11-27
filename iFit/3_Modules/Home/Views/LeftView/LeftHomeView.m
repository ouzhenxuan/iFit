//
//  LeftHomeView.m
//  iFit
//
//  Created by 区振轩 on 2017/10/24.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "LeftHomeView.h"
#import "LeftHeaderView.h"

@interface LeftHomeView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) LeftHeaderView * headerView;

@end

@implementation LeftHomeView




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 状态栏(statusbar)
        
        CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
        
        //标题栏
//        CGRect NavRect = self.navigationController.navigationBar.frame;
//        然后将高度相加，便可以动态计算顶部高度。
        
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,StatusRect.size.height , self.bounds.size.width, self.bounds.size.height-StatusRect.size.height) style:UITableViewStylePlain];
        
//        _tableview.backgroundColor = [UIColor greenColor];
        [self addSubview:_tableview];
        
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self setUpTheTableVie];
    }
    return self;
}

- (void)setUpTheTableVie{
    UIView * footView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _tableview.tableFooterView = footView;
    
    _headerView = [[LeftHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenBoundsWidth, 152)];
    [self setUpHeaderView];
    _tableview.tableHeaderView = _headerView;
}

- (void)setUpHeaderView{
    _headerView.ImageView.image = [UIImage imageNamed:@"lunch"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LeftHomeCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeftHomeCell"];
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.alpha = 0.3;
        [cell addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).with.mas_offset(@15);
            make.right.equalTo(cell);
            make.height.mas_equalTo(@1);
            make.bottom.equalTo(cell);
        }];
    }
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"sport"];
            cell.textLabel.text = @"我的目标";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"sport"];
            cell.textLabel.text = @"我的目标1";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"sport"];
            cell.textLabel.text = @"我的目标2";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"sport"];
            cell.textLabel.text = @"我的目标3";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        default:
            break;
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"kkkk %ld",(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}



@end
