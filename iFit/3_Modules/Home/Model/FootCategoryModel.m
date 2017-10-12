//
//  FootCategoryModel.m
//  iFit
//
//  Created by 区振轩 on 2017/10/11.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "FootCategoryModel.h"

@implementation FootCategoryModel

- (instancetype)initModelWithUrl:(NSString *)url title:(NSString *)title suggest:(NSString *)suggest{
    self.url = url;
    self.title = title;
    self.suggest = suggest;
    
    
    return self;
}

- (instancetype)initModelWithUrl:(NSString *)url title:(NSString *)title suggest:(NSString *)suggest footArray:(NSMutableArray * )footArray{
    self.url = url;
    self.title = title;
    self.suggest = suggest;
    self.footArray = footArray;
    
    return self;
}

@end
