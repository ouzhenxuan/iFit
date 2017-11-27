//
//  ZXMemberCenterCellItem.m
//  TopHot
//
//  Created by Liushannoon on 16/4/29.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import "ZXMemberCenterCellItem.h"

@implementation ZXMemberCenterCellItem

+ (instancetype)itemWithLeftImage:(UIImage *)leftImage leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage showSeparate:(BOOL)showSeparate showdSwitch:(BOOL)showdSwitch
{
    ZXMemberCenterCellItem *item = [[self alloc] init];
    item.leftImage = leftImage;
    item.leftTitle = leftTitle;
    item.rightTitle = rightTitle;
    item.rightImage = rightImage;
    item.showSeparate = showSeparate;
    item.showdSwitch = showdSwitch;
    return item;
}

+ (instancetype)itemWithLeftImage:(UIImage *)leftImage leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage leftImageWidth:(CGFloat)leftImageWidth showSeparate:(BOOL)showSeparate separateLeftInset:(CGFloat)separateLeftInset showdSwitch:(BOOL)showdSwitch;
{
    ZXMemberCenterCellItem *item = [[self alloc] init];
    item.leftImage = leftImage;
    item.leftTitle = leftTitle;
    item.rightTitle = rightTitle;
    item.rightImage = rightImage;
    item.showSeparate = showSeparate;
    item.showdSwitch = showdSwitch;
    item.leftImageWidth = leftImageWidth;
    item.separateLeftInset = separateLeftInset;
    return item;
}

+ (instancetype)itemWithLeftImage:(UIImage *)leftImage leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage showSeparate:(BOOL)showSeparate
{
    return [self itemWithLeftImage:leftImage leftTitle:leftTitle rightTitle:rightTitle rightImage:rightImage showSeparate:showSeparate showdSwitch:NO];
}

+ (instancetype)itemWithLeftImage:(UIImage *)leftImage leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage
{
    return [self itemWithLeftImage:leftImage leftTitle:leftTitle rightTitle:rightTitle rightImage:rightImage showSeparate:NO];
}

- (ZXMemberCenterCellType)cellType
{
    if (self.leftImage && self.leftTitle && self.rightTitle && self.rightImage) {
        /**
         *  左图 左文 右文 右图
         */
        return ZXMemberCenterCellTypeLILTRTRI;
    }
    if (self.leftImage && self.leftTitle && self.rightImage && self.rightTitle == nil) {
        /**
         *  左图 左文 右图
         */
        return ZXMemberCenterCellTypeLILTRI;
    }
    if (self.leftImage == nil && self.leftTitle && self.rightTitle && self.rightImage) {
        /**
         *   左文 右文 右图
         */
        return ZXMemberCenterCellTypeLTRTRI ;
    }
    if (self.leftImage == nil && self.leftTitle && self.rightTitle == nil && self.rightImage) {
        /**
         *  左文 右图
         */
        return ZXMemberCenterCellTypeLTRI;
    }
    if (self.leftImage && self.leftTitle && self.rightTitle == nil && self.rightImage == nil) {
        /**
         *  左图 左文
         */
        return ZXMemberCenterCellTypeLILT;
    }
    if (self.leftImage == nil && self.leftTitle && self.rightTitle && self.rightImage == nil) {
        /**
         *  左文 右文
         */
        return ZXMemberCenterCellTypeLTRT;
    }
    if (self.leftTitle && self.showdSwitch) {
        return ZXMemberCenterCellTypeLTRS;
    }
    if (self.leftTitle) {
        return ZXMemberCenterCellTypeLT;
    }
    return 0;
}

@end
