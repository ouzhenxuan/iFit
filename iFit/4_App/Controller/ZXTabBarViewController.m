//
//  ZXTabBarViewController.m
//  FixCar
//
//  Created by 区振轩 on 2017/6/13.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "ZXTabBarViewController.h"

#import "ZXNavigationController.h"
@interface ZXTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation ZXTabBarViewController

/**
 *  这个类或者他的子类第一次使用的时候调用
 */
+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self setupChildVc:[[HomePageController alloc] init] title:@"首页" image:@"tabbar_icon_flight_normal"selectedImage:@"tabbar_icon_flight_pressed"];
//    [self setupChildVc:[[ShopPageController alloc] init] title:@"商城" image:@"tabbar_icon_album_normal" selectedImage:@"tabbar_icon_album_pressed"];
//    [self setupChildVc:[[UserCenterController alloc] init] title:@"我" image:@"tabbar_icon_me_normal" selectedImage:@"tabbar_icon_me_pressed"];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    
    vc.tabBarItem.title = title;
    
    UIImage *tempImage = [UIImage imageNamed:image];
    tempImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tempSelectedImage = [UIImage imageNamed:selectedImage];
    tempSelectedImage = [tempSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.image = tempImage;
    vc.tabBarItem.selectedImage = tempSelectedImage;
    
    ZXNavigationController *nav = [[ZXNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = false;
    [self addChildViewController:nav];
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
