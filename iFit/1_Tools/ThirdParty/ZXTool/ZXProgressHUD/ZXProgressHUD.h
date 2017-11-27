//
//  ZXProgressHUD.h
//  EhangGhost2
//
//  Created by Liushannoon on 16/8/10.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXProgressHUD : NSObject

//+ (void)show;
//+ (void)showSuccessWithStatus:(NSString*)status;
//+ (void)showErrorWithStatus:(NSString*)status;
//+ (void)showWithStatus:(NSString*)status;
//
//+ (void)dismiss;


/**
 需要调用dismiss才会消失
 */
+ (void)showMBInView:(UIView *)view;
/**
 需要调用dismiss才会消失
 */
+ (void)showMBInView:(UIView *)view withTitle:(NSString *)title;
+ (void)showMBInView:(UIView *)view withTitle:(NSString *)title hideAfterTime:(NSTimeInterval)time;

/**
 0.7s后自动消失
 */
+ (void)showMBTip:(NSString *)title;
+ (void)showMBTip:(NSString *)title hideAfterTime:(NSTimeInterval)time;
+ (void)showMBTip:(NSString *)title hideAfterTime:(NSTimeInterval)time withTitleColor:(UIColor *)color;
+ (void)dismissMBInView:(UIView *)view;

@end
