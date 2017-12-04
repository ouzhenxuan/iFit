//
//  UIView+ZXExtension.m
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import "UIView+ZXExtension.h"
#import <objc/runtime.h>

@implementation UIView (ZXExtension)

#pragma mark    -    添加一个红点属性

static char RedTipViewKey;

- (UILabel *)redTipView
{
    return objc_getAssociatedObject(self,&RedTipViewKey);
}

- (void)setRedTipView:(UILabel *)redTipView
{
    objc_setAssociatedObject(self, &RedTipViewKey, redTipView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  在view上面绘制一个指定width宽度的红色提醒远点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 宽度
 */
- (void)zx_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width
{
    [self zx_showRedTipViewInRedX:redX redY:redY redTipViewWidth:width backgroundColor:[UIColor redColor]];
}

/**
 *  在view上面绘制一个指定width宽度的 指定颜色的提醒圆点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 圆点的直径
 *  @param color 圆点的颜色
 */
- (void)zx_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width backgroundColor:(UIColor *)backgroundColor
{
    [self zx_showRedTipViewInRedX:redX redY:redY redTipViewWidth:width backgroundColor:backgroundColor borderColor:[UIColor clearColor] borderWidth:0];
}

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
- (void)zx_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    if (self.redTipView) {
        [self zx_hideRedTipView];
    }
    self.redTipView = [[UILabel alloc] init];
    [self insertSubview:self.redTipView atIndex:self.subviews.count];
    if (borderWidth > 0 && borderColor != [UIColor clearColor]) {
        self.redTipView.backgroundColor = borderColor;
        self.redTipView.zx_width = width + borderWidth * 2;
        self.redTipView.zx_height = self.redTipView.zx_width;
        self.redTipView.layer.cornerRadius = self.redTipView.zx_height * 0.5;
        self.redTipView.layer.masksToBounds = YES;
        
        UIView *insetView = [[UIView alloc] init];
        insetView.backgroundColor = backgroundColor;
        insetView.zx_width = width;
        insetView.zx_height = width;
        insetView.zx_centerX = self.redTipView.zx_width * 0.5;
        insetView.zx_centerY = self.redTipView.zx_width * 0.5;
        insetView.layer.cornerRadius = insetView.zx_width *0.5;
        insetView.layer.masksToBounds = YES;
        [self.redTipView addSubview:insetView];
    } else {
        self.redTipView.backgroundColor = backgroundColor;
        self.redTipView.zx_width = width;
        self.redTipView.zx_height = width;
        self.redTipView.layer.cornerRadius = self.redTipView.zx_height * 0.5;
        self.redTipView.layer.masksToBounds = YES;
    }
    
    [self bringSubviewToFront:self.redTipView];
    self.redTipView.zx_x = redX;
    self.redTipView.zx_y = redY;
    self.redTipView.hidden = NO;

}

/**
 *  显示一个5*5点的红色提醒圆点
 *
 *  @param redX x坐标
 *  @param redY y坐标
 *  @param numberCount 展示的数字
 */
- (void)zx_showRedTipViewWithNumberCountInRedX:(CGFloat)redX redY:(CGFloat)redY numberCount:(NSInteger)numberCount
{
    if (self.redTipView) {
        [self zx_hideRedTipView];
    }
    self.redTipView = [[UILabel alloc] init];
    self.redTipView.backgroundColor = [UIColor redColor];
    self.redTipView.zx_x = redX;
    self.redTipView.zx_y = redY;
    self.redTipView.text = [NSString stringWithFormat:@"%zd",numberCount];
    self.redTipView.textAlignment = NSTextAlignmentCenter;
    self.redTipView.textColor = [UIColor whiteColor];
    self.redTipView.font = [UIFont systemFontOfSize:13];
    [self.redTipView sizeToFit];
    self.redTipView.zx_width += 8.5;
    self.redTipView.layer.cornerRadius = self.redTipView.zx_height * 0.5;
    self.redTipView.layer.masksToBounds = YES;
    [self insertSubview:self.redTipView atIndex:self.subviews.count];
    self.redTipView.hidden = NO;
}

/**
 *  隐藏红色提醒圆点
 */
- (void)zx_hideRedTipView
{
    self.redTipView.hidden = YES;
    [self.redTipView removeFromSuperview];
    self.redTipView = nil;
}

#pragma mark    -   计算frame

- (CGSize)zx_size
{
    return self.frame.size;
}

- (void)setZx_size:(CGSize)zx_size
{
    CGRect frame = self.frame;
    frame.size = zx_size;
    self.frame = frame;
}

- (CGFloat)zx_width
{
    return self.frame.size.width;
}

- (void)setZx_width:(CGFloat)zx_width
{
    CGRect rect = self.frame;
    rect.size.width = zx_width;
    self.frame = rect;
}

- (CGFloat)zx_height
{
    return self.frame.size.height;
}

- (void)setZx_height:(CGFloat)zx_height
{
    CGRect rect = self.frame;
    rect.size.height = zx_height;
    self.frame = rect;
}

- (CGFloat)zx_x
{
    return self.frame.origin.x;
}

- (void)setZx_x:(CGFloat)zx_x
{
    CGRect rect = self.frame;
    rect.origin.x = zx_x;
    self.frame = rect;
}

- (CGFloat)zx_y
{
    return self.frame.origin.y;
}

- (void)setZx_y:(CGFloat)zx_y
{
    CGRect rect = self.frame;
    rect.origin.y = zx_y;
    self.frame = rect;
}

- (CGFloat)zx_centerX
{
    return self.center.x;
}

- (void)setZx_centerX:(CGFloat)zx_centerX
{
    CGPoint point = self.center;
    point.x = zx_centerX;
    self.center = point;
}

- (CGFloat)zx_centerY
{
    return self.center.y;
}

- (void)setZx_centerY:(CGFloat)zx_centerY
{
    CGPoint point = self.center;
    point.y = zx_centerY;
    self.center = point;
}

#pragma mark    -   其他功能

/**
 *  判断是否在窗口上面
 */
- (BOOL)zx_isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = ZXKeyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

/**
 *  快速创建xib实例对象
 */
+ (instancetype)zx_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

/**
 *  对指定的layer进行弹性动画
 *
 *  @param layer 进行动画的图层
 *  @param type  动画类型
 */
+ (void)zx_showOscillatoryAnimationWithLayer:(CALayer *)layer type:(ZXAnimationType)type
{
    NSNumber *animationScale1 = type == ZXAnimationTypeToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == ZXAnimationTypeToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

/**
 *  给视图添加虚线边框
 *
 *  @param lineWidth  线宽
 *  @param lineMargin 每条虚线之间的间距
 *  @param lineLength 每条虚线的长度
 *  @param lineColor 每条虚线的颜色
 */
- (void)zx_addDottedLineBorderWithLineWidth:(CGFloat)lineWidth lineMargin:(CGFloat)lineMargin lineLength:(CGFloat)lineLength lineColor:(UIColor *)lineColor;
{
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = lineColor.CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    border.frame = self.bounds;
    
    border.lineWidth = lineWidth;
    
    border.lineCap = @"round";
    
    border.lineDashPattern = @[@(lineLength), @(lineMargin)];
    
    [self.layer addSublayer:border];
}

- (void)zx_removeAllSubviews
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
        if (subView.subviews) {
            [subView zx_removeAllSubviews];
        }
    }
}

@end
