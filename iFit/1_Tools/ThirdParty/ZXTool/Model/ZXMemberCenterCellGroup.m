//
//  ZXMemberCenterCellGroup.m
//  ZXTool
//
//  Created by ehang on 2016/10/19.
//  Copyright © 2016年 shannoon. All rights reserved.
//

#import "ZXMemberCenterCellGroup.h"

@implementation ZXMemberCenterCellGroup

+ (instancetype)groupWithItems:(NSArray *)items headerTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    ZXMemberCenterCellGroup *group = [[self alloc] init];
    
    group.items = items;
    group.headerTitle = headerTitle;
    group.footerTitle = footerTitle;
    
    return group;
}

+ (instancetype)groupWithItems:(NSArray *)items
{
    return [self groupWithItems:items headerTitle:nil footerTitle:nil];
}

@end
