//
//  ZXBaseWebViewController.h
//  EhangGhost2
//
//  Created by Liushannoon on 16/8/10.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHViewController.h"

@interface ZXBaseWebViewController : EHViewController <UIWebViewDelegate>

@property (nonatomic , strong , readonly) NSString  *urlString;
@property (nonatomic , strong) UIWebView  *webView;
/** 进度条颜色 */
@property (nonatomic , strong) UIColor  *progressColor;
/** 进度条的高度 */
@property (nonatomic , assign) CGFloat  progressHeight;
/** 提醒视图的文字颜色 */
@property (nonatomic , strong) UIColor  *tipStringColor;
/** 提醒视图的文字大小 */
@property (nonatomic , strong) UIFont  *tipStringFont;

- (instancetype)initWithURLString:(NSString *)urlString refreshHeader:(BOOL)refreshHeader failureTipImage:(UIImage *)failureTipImage failureTipString:(NSString *)failureTipString failureTipTapBlock:(MyVoidBlock)failureTipTapBlock;
- (void)loadURLWithURLString:(NSString *)string;

@end
