//
//  ZXNavigationController.m
//  FixCar
//
//  Created by 区振轩 on 2017/6/13.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "ZXNavigationController.h"
#import "ZXConstants.h"

@interface ZXNavigationController ()<UINavigationControllerDelegate>

/** 记录系统的滑动返回代理 */
@property (nonatomic , strong) id  popDelegate;
/** 导航条内部的分割线 */
@property (nonatomic , strong) UIImageView  *bottomDividingView;

@end



@implementation ZXNavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.translucent = NO;
    bar.barTintColor = [UIColor whiteColor]; // 背景色
    bar.tintColor = [UIColor blackColor];
    bar.shadowImage = [UIImage new];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
    UIImage *backButtonImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [bar setBackIndicatorImage:backButtonImage];
    [bar setBackIndicatorTransitionMaskImage:backButtonImage];
    
    [bar setTitleTextAttributes:@{NSFontAttributeName : S4 , NSForegroundColorAttributeName : ZXColor_515151}];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = C9;
    itemAttrs[NSFontAttributeName] = S2;
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[backButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backButtonImage.size.width, 0, 0) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault]; // 图片会被拉伸,需要UI横向多切一个点
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
