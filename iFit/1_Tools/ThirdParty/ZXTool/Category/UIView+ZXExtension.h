//
//  UIView+ZXExtension.h
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZXScreenBounds [UIScreen mainScreen].bounds
#define ZXScreenSize [UIScreen mainScreen].bounds.size
#define ZXScreenW [UIScreen mainScreen].bounds.size.width
#define ZXScreenH [UIScreen mainScreen].bounds.size.height
#define zx_autoSizeScaleX ([UIScreen mainScreen].bounds.size.width / 414)
#define zx_autoSizeScaleY ([UIScreen mainScreen].bounds.size.height / 736)
#define zx_scaleInX_iPhone6(float) (([UIScreen mainScreen].bounds.size.width / 375.0) * (float))
#define zx_scaleInY_iPhone6(float) (([UIScreen mainScreen].bounds.size.height / 667.0) * (float))

#define ZXDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
#define ZXKeyWindow [UIApplication sharedApplication].windows.firstObject

/**
 *  动画类型
 */
typedef NS_ENUM(NSUInteger, ZXAnimationType){
    /**
     *  弹性动画放大
     */
    ZXAnimationTypeToBigger = 1,
    /**
     *  缩小的弹性动画
     */
    ZXAnimationTypeToSmaller = 2
};

@interface UIView (ZXExtension)

@property (nonatomic, assign) CGFloat zx_height;
@property (nonatomic, assign) CGFloat zx_width;
@property (nonatomic, assign) CGFloat zx_x;
@property (nonatomic, assign) CGFloat zx_y;
@property (nonatomic, assign) CGSize zx_size;
@property (nonatomic, assign) CGFloat zx_centerX;
@property (nonatomic, assign) CGFloat zx_centerY;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)zx_isShowingOnKeyWindow;

/**
 *  加载xibview
 */
+ (instancetype)zx_viewFromXib ;

/**
 *  在view上面绘制一个指定width宽度的红色提醒圆点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 宽度
 */
- (void)zx_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width ;
/**
 *  在view上面绘制一个指定width宽度的 指定颜色的提醒圆点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 圆点的直径
 *  @param color 圆点的颜色
 */
- (void)zx_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width backgroundColor:(UIColor *)backgroundColor;
/**
 *  在view上面绘制一个指定width宽度的 指定颜色的提醒圆点,带描边
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 圆点的直径
 *  @param color 圆点的颜色
 *  @param borderColor 圆点的描边颜色
 *  @param borderWidth 圆点的描边宽度
 */
- (void)zx_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
/**
 *  显示一个5*5点的红色提醒圆点
 *
 *  @param redX x坐标
 *  @param redY y坐标
 *  @param numberCount 展示的数字
 */
- (void)zx_showRedTipViewWithNumberCountInRedX:(CGFloat)redX redY:(CGFloat)redY numberCount:(NSInteger)numberCount;

/**
 *  隐藏红色提醒圆点
 */
- (void)zx_hideRedTipView;

/**
 *  类方法,对指定的layer进行弹性动画
 *
 *  @param layer 进行动画的图层
 *  @param type  动画类型
 */
+ (void)zx_showOscillatoryAnimationWithLayer:(CALayer *)layer type:(ZXAnimationType)type;
/**
 *  给视图添加虚线边框
 *
 *  @param lineWidth  线宽
 *  @param lineMargin 每条虚线之间的间距
 *  @param lineLength 每条虚线的长度
 *  @param lineColor 每条虚线的颜色
 */
- (void)zx_addDottedLineBorderWithLineWidth:(CGFloat)lineWidth lineMargin:(CGFloat)lineMargin lineLength:(CGFloat)lineLength lineColor:(UIColor *)lineColor;
- (void)zx_removeAllSubviews;

@end
