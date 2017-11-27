//
//  LeftHeaderView.m
//  iFit
//
//  Created by 区振轩 on 2017/11/13.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "LeftHeaderView.h"

@implementation LeftHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LeftHeaderView" owner:nil options:nil].lastObject;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LeftHeaderView" owner:nil options:nil].lastObject;
    }
    return self;
}



@end
