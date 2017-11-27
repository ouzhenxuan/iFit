//
//  ZXMemberCenterCellItem.h
//  TopHot
//
//  Created by Liushannoon on 16/4/29.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//
/**
 *  个人中心的cell模型
 */

#import <Foundation/Foundation.h>
#define ZXDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

/**
 *  类型
 */
typedef NS_ENUM(NSUInteger, ZXMemberCenterCellType){
    /**
     *  左图 左文 右文 右图
     */
    ZXMemberCenterCellTypeLILTRTRI = 1,
    /**
     *  左图 左文 右图
     */
    ZXMemberCenterCellTypeLILTRI = 2,
    /**
     *   左文 右文 右图
     */
    ZXMemberCenterCellTypeLTRTRI = 3,
    /**
     *  左文 右图
     */
    ZXMemberCenterCellTypeLTRI = 4,
    /**
     *  左图 左文
     */
    ZXMemberCenterCellTypeLILT = 5,
    /**
     *  左文 右文
     */
    ZXMemberCenterCellTypeLTRT = 6,
    /**
     *  左文 右开关
     */
    ZXMemberCenterCellTypeLTRS = 7,
    /**
     *  左文
     */
    ZXMemberCenterCellTypeLT = 8
    
};

@interface ZXMemberCenterCellItem : NSObject

/**
 *  是否显示提醒红点
 */
@property (nonatomic , assign) BOOL isShowRedTip;
/**
 *  cell的类型
 */
@property (nonatomic , assign , readonly) ZXMemberCenterCellType cellType;
/**
 *  最左边的图片
 */
@property (nonatomic, strong) UIImage *leftImage;
/**
 *  左图的宽度
 */
@property (nonatomic , assign) CGFloat  leftImageWidth;
/**
 * 左边的title
 */
@property (nonatomic, strong) NSString *leftTitle;
/**
 *  右边的title
 */
@property (nonatomic , strong) NSString *rightTitle;
/**
 *  最右边的辅助图片
 */
@property (nonatomic , strong) UIImage *rightImage;
/**
 *  用来保存每一行cell的功能
 */
@property (nonatomic, strong) void(^itemOpertion)(NSIndexPath *indexPath);
/**
 *  用来保存每一行开关切换对应的董恩给你
 */
@property(nonatomic, copy) void(^switchValueChangeBlock)(BOOL switchValue);
/**
 *  是否显示分割线
 */
@property (nonatomic , assign) BOOL showSeparate;
/**
 *  分割线距离左边的间距
 */
@property (nonatomic , assign) CGFloat  separateLeftInset;
/**
 *  最右边的开关视图,显示的时候,隐藏最右边的图片,默认为NO
 */
@property (nonatomic , assign) BOOL showdSwitch;
/**
 *  开关状态,默认为NO
 */
@property(nonatomic, assign) BOOL switchOn;

+ (instancetype)itemWithLeftImage:(UIImage *)leftImage leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage ZXDeprecated("请使用其他类方法");
+ (instancetype)itemWithLeftImage:(UIImage *)leftImage leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage showSeparate:(BOOL)showSeparate ZXDeprecated("请使用其他类方法");
+ (instancetype)itemWithLeftImage:(UIImage *)leftImage leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage showSeparate:(BOOL)showSeparate showdSwitch:(BOOL)showdSwitch;
/**
 *  指定左图宽度,分割线间距
 *
 *  @param leftImage         <#leftImage description#>
 *  @param leftTitle         <#leftTitle description#>
 *  @param rightTitle        <#rightTitle description#>
 *  @param rightImage        <#rightImage description#>
 *  @param leftImageWidth    <#leftImageWidth description#>
 *  @param showSeparate      <#showSeparate description#>
 *  @param separateLeftInset <#separateLeftInset description#>
 *  @param showdSwitch       <#showdSwitch description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)itemWithLeftImage:(UIImage *)leftImage leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage leftImageWidth:(CGFloat)leftImageWidth showSeparate:(BOOL)showSeparate separateLeftInset:(CGFloat)separateLeftInset showdSwitch:(BOOL)showdSwitch;

@end
