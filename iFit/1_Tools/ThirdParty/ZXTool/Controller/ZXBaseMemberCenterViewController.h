//
//  ZXBaseMemberCenterViewController.h
//  TopHot
//
//  Created by Liushannoon on 16/5/3.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXBottomMultiPurposeView.h"

#import "ZXMemberCenterCellItem.h"
#import "ZXMemberCenterCellGroup.h"

#import "ZXMemberCenterCell.h"
#import "EHViewController.h"


@interface ZXBaseMemberCenterViewController : EHViewController < UIActionSheetDelegate,ZXBottomMultiPurposeViewDelegate , UITableViewDelegate , UITableViewDataSource >

/** 记录所有cell组的数据 */
@property (nonatomic , strong) NSMutableArray  *groups;
/**
 *  tableView
 */
@property (nonatomic , strong) UITableView  *tableView;

@end
