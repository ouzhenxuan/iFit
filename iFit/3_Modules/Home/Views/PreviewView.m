//
//  PreviewView.m
//  iFit
//
//  Created by 区振轩 on 2017/9/13.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "PreviewView.h"
#import "CircleView.h"
#import "LabelNumView.h"

@interface PreviewView ()

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) LabelNumView * eatCalorie;

@property (nonatomic,strong) LabelNumView * sportView;

@property (nonatomic,strong) UIView * goalView;
@property (nonatomic,strong) UILabel * goalLabel;
@property (nonatomic,strong) UILabel * goalNum;


@end


@implementation PreviewView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUpUI];
        [self setNeedsUpdateConstraints];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}


- (void) setUpUI{
    __weak typeof(self) weakSelf = self;
    
    _eatCalorie = [[LabelNumView alloc] initViewWithNum:213 Title:@"食物摄入"];
    _eatCalorie.backgroundColor = [UIColor clearColor];
    [self addSubview:_eatCalorie];
    
    _sportView = [[LabelNumView alloc] initViewWithNum:778 Title:@"运动"];
    _sportView.backgroundColor = [UIColor clearColor];
    [self addSubview:_sportView];
    
    _goalView = [[UIView alloc] init];
    _goalView.backgroundColor = [UIColor clearColor];
    [self addSubview:_goalView];
    
    CircleView * circleView = [[CircleView alloc] initCircleViewWithRadius:60.0 Center:CGPointMake(70, 70)];
    [_goalView addSubview:circleView];
    
    
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.goalView);
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.goalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(140 , 140));
    }];
    
    [self.eatCalorie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.goalView.mas_left).mas_offset(@-10);
        make.left.equalTo(weakSelf).mas_offset(@10);
        make.height.mas_offset(43);
    }];
    
    [self.sportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf).mas_offset(@-10);
        make.left.equalTo(weakSelf.goalView.mas_right).mas_offset(@10);
        make.height.mas_offset(43);
    }];
}


@end
