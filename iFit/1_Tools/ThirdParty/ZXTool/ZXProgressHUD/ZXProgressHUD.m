//
//  ZXProgressHUD.m
//  EhangGhost2
//
//  Created by Liushannoon on 16/8/10.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import "ZXProgressHUD.h"
//#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "ZXTool.h"

@implementation ZXProgressHUD

//+ (void)initialize
//{
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
//    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
//    [SVProgressHUD setDefaultMaskType:1];
//}
//
//+ (void)show
//{
//    [SVProgressHUD show];
//}
//
//+ (void)showSuccessWithStatus:(NSString*)status
//{
//    [SVProgressHUD showSuccessWithStatus:status maskType:1];
//}
//
//+ (void)showErrorWithStatus:(NSString*)status
//{
//    [SVProgressHUD showErrorWithStatus:status maskType:1];
//}
//
//+ (void)showWithStatus:(NSString*)status
//{
//    [SVProgressHUD showWithStatus:status maskType:1];
//}
//
//+ (void)dismiss
//{
//    [SVProgressHUD dismiss];
//}

#pragma mark    -   MBProgressHUD封装


+ (void)showMBInView:(UIView *)view
{
    [self showMBInView:view withTitle:nil];
}

+ (void)showMBInView:(UIView *)view withTitle:(NSString *)title
{
    [self showMBInView:view withTitle:title hideAfterTime:MAXFLOAT];
}

+ (void)showMBInView:(UIView *)view withTitle:(NSString *)title hideAfterTime:(NSTimeInterval)time
{
    if (view == nil) {
        AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
        view = ad.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabelText = title;
    hud.detailsLabelColor = [UIColor whiteColor];
    hud.detailsLabelFont = [UIFont systemFontOfSize:43 / 3.0];
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.margin = (40.0 / 3 * zx_autoSizeScaleX);
    [hud hide:YES afterDelay:time];

}

+ (void)showMBTip:(NSString *)title
{
    [self showMBTip:title hideAfterTime:0.7];
}

+ (void)showMBTip:(NSString *)title hideAfterTime:(NSTimeInterval)time
{
    [self showMBTip:title hideAfterTime:time withTitleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:43 / 3.0]];
}

+ (void)showMBTip:(NSString *)title hideAfterTime:(NSTimeInterval)time withTitleColor:(UIColor *)color
{
    [self showMBTip:title hideAfterTime:time withTitleColor:color titleFont:[UIFont systemFontOfSize:43 / 3.0]];
}

+ (void)showMBTip:(NSString *)title hideAfterTime:(NSTimeInterval)time withTitleColor:(UIColor *)color titleFont:(UIFont *)font
{
    AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:ad.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = title;
    hud.detailsLabelColor = color;
    hud.detailsLabelFont = font;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.margin = (40.0 / 3 * zx_autoSizeScaleX);

    [hud hide:YES afterDelay:time];
}

+ (void)dismissMBInView:(UIView *)view
{
    if (view == nil) {
        AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
        view = ad.window;
    }
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
