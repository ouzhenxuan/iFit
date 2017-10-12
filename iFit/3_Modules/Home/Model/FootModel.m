//
//  FootModel.m
//  iFit
//
//  Created by 区振轩 on 2017/10/12.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "FootModel.h"

@implementation FootModel

- (instancetype)initModelWithCalorie:(double)calorie fat:(double)fat{
    self.calorie = calorie;
    self.fat = fat;
    return self;
}

@end
