//
//  LeftHomeView.m
//  iFit
//
//  Created by 区振轩 on 2017/10/24.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "LeftHomeView.h"

@interface LeftHomeView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableview;

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
        self.backgroundColor = [UIColor yellowColor];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height-40) style:UITableViewStylePlain];
        
        _tableview.backgroundColor = [UIColor greenColor];
        [self addSubview:_tableview];
        
        _tableview.dataSource = self;
        _tableview.delegate = self;
        
        
    }
    return self;
}

- (void)setUpTheTableVie{
    UIView * footView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _tableview.tableFooterView = footView;
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenBoundsWidth, 210)];
    headerView.backgroundColor = [UIColor yellowColor];
    _tableview.tableHeaderView = headerView;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LeftHomeCell"];
    cell.textLabel.text = @"123123";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}



@end
