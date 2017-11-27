//
//  ZXMemberCenterCellGroup.h
//  ZXTool
//
//  Created by ehang on 2016/10/19.
//  Copyright © 2016年 shannoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXMemberCenterCellGroup : NSObject

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;

+ (instancetype)groupWithItems:(NSArray *)items;
+ (instancetype)groupWithItems:(NSArray *)items headerTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

@end
