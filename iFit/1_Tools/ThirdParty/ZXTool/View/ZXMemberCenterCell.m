//
//  ZXMemberCenterCell.m
//  TopHot
//
//  Created by Liushannoon on 16/4/29.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import "ZXMemberCenterCell.h"
#import "UIView+ZXExtension.h"
#import "UILabel+adjust.h"

#define kLeftMargin 15
#define kRightMargin 15
#define kLILTMiddleMargin 10
#define kRIRTMiddleMargin 10
#define kRedTipViewRightMargin 40
#define kRedTipViewHeight 6

#define kLeftLabelColor C4
#define kLeftLabelFont S3
#define kRightLabelColor C5
#define kRightLabelFont S2
#define kSeperateColor [UIColor grayColor]

@interface ZXMemberCenterCell ()

/**
 *  左边图片视图
 */
@property (nonatomic , strong) UIImageView *leftImageView;
/**
 *  左边label
 */
@property (nonatomic , strong) UILabel *leftLabel;
/**
 *  right label
 */
@property (nonatomic , strong) UILabel *rightLabel;
/**
 *  right imageView
 */
@property (nonatomic , strong) UIImageView  *rightImageView;
/**
 *  分割线
 */
@property (nonatomic , strong) UIView  *separateView;
@property (nonatomic , strong) UISwitch  *switchView;

@end

@implementation ZXMemberCenterCell

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [self.contentView addSubview:_switchView];
        _switchView.onTintColor = C9;
        [_switchView addTarget:self action:@selector(switchChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

/**
 *  懒加载成员属性
 */
- (UIImageView *)leftImageView
{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_leftImageView];
    }
    
    return _leftImageView;
}
/**
 *  懒加载成员属性
 */
- (UIImageView *)rightImageView
{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_rightImageView];
    }
    
    return _rightImageView;
}
/**
 *  懒加载成员属性
 */
- (UILabel *)leftLabel
{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_leftLabel];
        _leftLabel.font = kLeftLabelFont;
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = kLeftLabelColor;
        _leftLabel.numberOfLines = 1;
        [_leftLabel adjustByDefaultScale];
    }
    
    return _leftLabel;
}
/**
 *  懒加载成员属性
 */
- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_rightLabel];
        _rightLabel.font =kRightLabelFont;
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.textColor = kRightLabelColor;
        _rightLabel.numberOfLines = 1;
        [_rightLabel adjustByDefaultScale];
    }
    
    return _rightLabel;
}

/**
 *  懒加载成员属性
 */
- (UIView *)separateView
{
    if (_separateView == nil) {
        _separateView = [[UIView alloc] init];
        [self.contentView addSubview:_separateView];
        _separateView.hidden = YES;
        _separateView.backgroundColor = kSeperateColor;
    }
    
    return _separateView;
}

#pragma mark    -   initial view

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initial];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initial];
    }
    return self;
}

/**
 *  初始化
 */
- (void)initial
{
    ZXFormatLog(@"2222222222");
    self.leftImageView.contentMode = UIViewContentModeLeft;
    self.rightImageView.contentMode =UIViewContentModeRight;
    self.leftImageView.backgroundColor = [UIColor clearColor];
    self.rightImageView.backgroundColor = [UIColor clearColor];
    self.leftLabel.backgroundColor = [UIColor clearColor];
    self.leftLabel.backgroundColor = [UIColor clearColor];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

- (void)setCellItem:(ZXMemberCenterCellItem *)cellItem
{
    _cellItem = cellItem;
    
    self.leftImageView.image = cellItem.leftImage;
    self.leftLabel.text = cellItem.leftTitle;
    self.rightImageView.image = cellItem.rightImage;
    self.rightLabel.text = cellItem.rightTitle;

    // 根据模型布局
    [self layoutWithCellItem:cellItem];
    
    if (cellItem.showSeparate) {
        if (cellItem.separateLeftInset == 0) {
            cellItem.separateLeftInset = kLeftMargin;
        }
        self.separateView.hidden = NO;
//        self.separateView.sd_layout
//        .bottomEqualToView(self.contentView)
//        .heightIs(0.5)
//        .rightEqualToView(self.contentView)
//        .leftSpaceToView(self.contentView , cellItem.separateLeftInset);
    } else {
        self.separateView.hidden = YES;
    }
    
    if (cellItem.isShowRedTip == YES) {
        [self zx_showRedTipViewInRedX:(ZXScreenW - kRedTipViewRightMargin) redY:(self.zx_height - kRedTipViewHeight) * 0.5 redTipViewWidth:kRedTipViewHeight backgroundColor:[UIColor redColor]];
    } else {
        [self zx_hideRedTipView];
    }
    
    [self.switchView setOn:cellItem.switchOn animated:YES];
}

#pragma mark    -----------
#pragma mark    -   private

- (void)switchChangeValue:(UISwitch *)switchView
{
    self.cellItem.switchOn = switchView.isOn;
    if (self.cellItem.switchValueChangeBlock) {
        self.cellItem.switchValueChangeBlock(switchView.isOn);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutWithCellItem:self.cellItem];
}

- (void)layoutWithCellItem:(ZXMemberCenterCellItem *)cellItem
{
//    NSLog(@"layoutWithCellItem cell.frame = %@",NSStringFromCGRect(self.frame));
    self.leftImageView.hidden = YES;
    self.rightImageView.hidden = YES;
    self.leftLabel.hidden = YES;
    self.rightLabel.hidden = YES;
    self.switchView.hidden = YES;
    
    switch (cellItem.cellType) {
        case ZXMemberCenterCellTypeLILTRTRI:
        {
            self.leftImageView.hidden = NO;
            self.leftLabel.hidden = NO;
            self.rightImageView.hidden = NO;
            self.rightLabel.hidden = NO;
            
            if (cellItem.leftImageWidth == 0) {
                cellItem.leftImageWidth = 30;
            }
            
            self.leftImageView.zx_x = zx_scaleInX_iPhone6(kLeftMargin);
            self.leftImageView.zx_width = zx_scaleInX_iPhone6(20);
            self.leftImageView.zx_height = zx_scaleInX_iPhone6(20);
            self.leftImageView.zx_centerY = self.zx_height * 0.5;
            
            self.leftLabel.zx_x = CGRectGetMaxX(self.leftImageView.frame) + zx_scaleInX_iPhone6(15);
            self.leftLabel.zx_y = 0;
            self.leftLabel.zx_height = self.zx_height;
            self.leftLabel.zx_width = self.zx_width * 0.4;
            
            self.rightImageView.zx_width = zx_scaleInX_iPhone6(7);
            self.rightImageView.zx_height = zx_scaleInX_iPhone6(12);
            self.rightImageView.zx_centerY = self.zx_height * 0.5;
            self.rightImageView.zx_x = self.zx_width - self.rightImageView.zx_width - zx_scaleInX_iPhone6(kRightMargin) ;
            
            self.rightLabel.zx_width = (CGRectGetMinX(self.rightImageView.frame) - zx_scaleInX_iPhone6(15)) - (CGRectGetMaxX(self.leftLabel.frame) + 5) ;
            self.rightLabel.zx_height = self.zx_height;
            self.rightLabel.zx_x = (CGRectGetMaxX(self.leftLabel.frame) + 5);
            self.rightLabel.zx_y = 0;
        }
            break;
        case ZXMemberCenterCellTypeLILTRI:
        {
            self.leftImageView.hidden = NO;
            self.leftLabel.hidden = NO;
            self.rightImageView.hidden = NO;
            
            if (cellItem.leftImageWidth == 0) {
                cellItem.leftImageWidth = 30;
            }

            self.leftImageView.zx_x = zx_scaleInX_iPhone6(kLeftMargin);
            self.leftImageView.zx_width = zx_scaleInX_iPhone6(20);
            self.leftImageView.zx_height = zx_scaleInX_iPhone6(20);
            self.leftImageView.zx_centerY = self.zx_height * 0.5;
            
            self.leftLabel.zx_x = CGRectGetMaxX(self.leftImageView.frame) + zx_scaleInX_iPhone6(15);
            self.leftLabel.zx_y = 0;
            self.leftLabel.zx_height = self.zx_height;
            self.leftLabel.zx_width = self.zx_width * 0.5;

            self.rightImageView.zx_width = zx_scaleInX_iPhone6(7);
            self.rightImageView.zx_height = zx_scaleInX_iPhone6(12);
            self.rightImageView.zx_centerY = self.zx_height * 0.5;
            self.rightImageView.zx_x = self.zx_width - self.rightImageView.zx_width - zx_scaleInX_iPhone6(kRightMargin) ;

        }
            break;
        case ZXMemberCenterCellTypeLTRTRI:
        {
            // 左文  右文 右图
            self.leftLabel.hidden = NO;
            self.rightImageView.hidden = NO;
            self.rightLabel.hidden = NO;
            
            self.leftLabel.zx_x = zx_scaleInX_iPhone6(kLeftMargin);
            self.leftLabel.zx_y = 0;
            self.leftLabel.zx_height = self.zx_height;
            self.leftLabel.zx_width = self.zx_width * 0.5;
            
            self.rightImageView.zx_width = zx_scaleInX_iPhone6(7);
            self.rightImageView.zx_height = zx_scaleInX_iPhone6(12);
            self.rightImageView.zx_centerY = self.zx_height * 0.5;
            self.rightImageView.zx_x = self.zx_width - self.rightImageView.zx_width - zx_scaleInX_iPhone6(kRightMargin) ;
            
            self.rightLabel.zx_width = self.zx_width * 0.3;
            self.rightLabel.zx_height = self.zx_height;
            self.rightLabel.zx_y = 0;
            self.rightLabel.zx_x = CGRectGetMinX(self.rightImageView.frame) - zx_scaleInX_iPhone6(12) - self.rightLabel.zx_width;
        }
            break;
            
        case ZXMemberCenterCellTypeLTRI:
        {
            // 左文 右图
            self.leftLabel.hidden = NO;
            self.rightImageView.hidden = NO;
            
//            self.leftLabel.sd_layout
//            .leftSpaceToView(self.contentView , kLeftMargin)
//            .topEqualToView(self.contentView)
//            .bottomEqualToView(self.contentView)
//            .widthIs(100);
//            
//            self.rightImageView.sd_layout
//            .rightSpaceToView(self.contentView , kRightMargin)
//            .topEqualToView(self.contentView)
//            .bottomEqualToView(self.contentView)
//            .widthIs(20);
            
        }
            break;
        case ZXMemberCenterCellTypeLTRT:
        {
            // 左文 右文
            self.rightLabel.hidden = NO;
            self.leftLabel.hidden = NO;
            
            self.leftLabel.zx_x = zx_scaleInX_iPhone6(kLeftMargin);
            self.leftLabel.zx_y = 0;
            self.leftLabel.zx_height = self.zx_height;
            self.leftLabel.zx_width = self.zx_width * 0.3;

            self.rightLabel.zx_x = self.zx_width - self.rightLabel.zx_width - zx_scaleInX_iPhone6(kRightMargin);
            self.rightLabel.zx_y = 0;
            self.rightLabel.zx_height = self.zx_height;
            self.rightLabel.zx_width = self.zx_width * 0.3;
            
        }
            break;
        case ZXMemberCenterCellTypeLTRS: // 左文右开关
        {
            self.leftLabel.hidden = NO;
            self.switchView.hidden = NO;
            
            self.switchView.zx_width = zx_scaleInY_iPhone6(37);
            self.switchView.zx_height = zx_scaleInY_iPhone6(20);
            self.switchView.zx_centerY = self.zx_height * 0.5;
            self.switchView.zx_x = self.zx_width - self.switchView.zx_width - zx_scaleInX_iPhone6(kRightMargin);
            
            self.leftLabel.zx_x = zx_scaleInX_iPhone6(kLeftMargin);
            self.leftLabel.zx_y = 0;
            self.leftLabel.zx_height = self.zx_height;
            self.leftLabel.zx_width = self.zx_width - zx_scaleInX_iPhone6(kRightMargin) * 2 - self.switchView.zx_width - 15;

        }
            break;
        case ZXMemberCenterCellTypeLT:
        {
            self.leftLabel.hidden = NO;

            self.leftLabel.zx_x = zx_scaleInX_iPhone6(kLeftMargin);
            self.leftLabel.zx_y = 0;
            self.leftLabel.zx_height = self.zx_height;
            self.leftLabel.zx_width = self.zx_width * 0.7;
        }
            break;
        default:
            break;
    }
}
@end
