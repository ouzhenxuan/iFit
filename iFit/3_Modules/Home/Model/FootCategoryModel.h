//
//  footCategoryModel.h
//  iFit
//
//  Created by 区振轩 on 2017/10/11.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FootCategoryModel : NSObject

@property (nonatomic,copy) NSString * url;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * suggest;

@property (nonatomic,strong) NSMutableArray * footArray;


- (instancetype)initModelWithUrl:(NSString *)url title:(NSString *)title suggest:(NSString *)suggest;

- (instancetype)initModelWithUrl:(NSString *)url title:(NSString *)title suggest:(NSString *)suggest footArray:(NSMutableArray * )footArray;
@end
