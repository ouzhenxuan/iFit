//
//  ZXMemberCenterCell.h
//  TopHot
//
//  Created by Liushannoon on 16/4/29.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//
/**
 *  个人中心/设置界面cell
 */

#import <UIKit/UIKit.h>
#import "ZXMemberCenterCellItem.h"
#import "ZXTool.h"

@interface ZXMemberCenterCell : UITableViewCell

/**
 *  cell的模型
 */
@property (nonatomic , strong) ZXMemberCenterCellItem *cellItem;
/**
 *  左边图片视图
 */
@property (nonatomic , strong , readonly) UIImageView *leftImageView;
/**
 *  左边label
 */
@property (nonatomic , strong , readonly) UILabel *leftLabel;
/**
 *  right label
 */
@property (nonatomic , strong , readonly) UILabel *rightLabel;
/**
 *  right imageView
 */
@property (nonatomic , strong , readonly) UIImageView  *rightImageView;
/**
 *  分割线
 */
@property (nonatomic , strong , readonly) UIView  *separateView;
@property (nonatomic , strong , readonly) UISwitch  *switchView;

@end
