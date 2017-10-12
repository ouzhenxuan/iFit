//
//  FootModel.h
//  iFit
//
//  Created by 区振轩 on 2017/10/12.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FootModel : NSObject

@property (nonatomic,assign) double calorie;

@property (nonatomic,assign) double fat;

- (instancetype)initModelWithCalorie:(double)calorie fat:(double)fat;
@end
