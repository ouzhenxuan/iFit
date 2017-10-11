//
//  FootTableView.m
//  iFit
//
//  Created by 区振轩 on 2017/10/10.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "FootTableView.h"

@interface FootTableView () <UITableViewDelegate,UITableViewDataSource>


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
        
    }
    
    return self;
}

- (void)registerTheTableViewHeight:(void(^)(double height))block{
    heightReflashBlock = nil;
    heightReflashBlock = [block copy];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    heightReflashBlock(40*10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    cell.textLabel.text = @"123";
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


@end
