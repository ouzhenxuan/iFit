//
//  ZXNavigationController.m
//  FixCar
//
//  Created by 区振轩 on 2017/6/13.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "ZXNavigationController.h"
#import "ZXConstants.h"
#import "PSDrawerManager.h"

@interface ZXNavigationController ()<UINavigationControllerDelegate>

/** 记录系统的滑动返回代理 */
@property (nonatomic , strong) id  popDelegate;
/** 导航条内部的分割线 */
@property (nonatomic , strong) UIImageView  *bottomDividingView;
@property (nonatomic,strong) UIView * grayMaskView;

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
    
    [self setUpTheLeftGrayView];
    // Do any additional setup after loading the view.
}

/**
 设置左边侧滑控件出现时，主页上的灰色蒙版
 */
- (void)setUpTheLeftGrayView{
    self.grayMaskView = [[UIView alloc] init];
    self.grayMaskView.backgroundColor = [UIColor grayColor];
    self.grayMaskView.alpha = 0.0;
    self.grayMaskView.frame = CGRectMake(0, 0, ScreenBoundsWidth, ScreenBoundsHeight);
    [self.view addSubview:self.grayMaskView];
    [self.grayMaskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGrayMaskView)]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showGrayView) name:kLeftViewWillAppear object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideGrayView) name:kLeftViewWillDisAppear object:nil];
}

- (void)clickGrayMaskView
{
    [[PSDrawerManager sharedInstance] resetShowType:PSDrawerManagerShowCenter];
}

- (void)hideGrayView
{
    [UIView animateWithDuration:0.15 animations:^{
        self.grayMaskView.alpha = 0.0;
    }];
}

- (void)showGrayView
{
    [UIView animateWithDuration:0.15 animations:^{
        self.grayMaskView.alpha = 0.4;
    }];
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
