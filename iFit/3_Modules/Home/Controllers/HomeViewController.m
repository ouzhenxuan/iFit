//
//  ViewController.m
//  iFit
//
//  Created by 区振轩 on 2017/9/8.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "HomeViewController.h"
#import "PreviewView.h"
//#import "UIColor+HexColor.h"
#import "UIColor+ZXExtension.h"
#import "FootTableView.h"
#import "PSDrawerManager.h"
#import "ChooseFoodTypeView.h"
#import "ChooseFoodTypeController.h"

@interface HomeViewController () <UIScrollViewDelegate>
//view
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIView * grayView;

@property (nonatomic,strong) PreviewView * preview;
@property (nonatomic,strong) FootTableView * footTableView;




//feild
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"星期五";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_info.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
//    添加scrollview里面的内容
    [self setUpTheScrollView];
//    添加能拖动的添加按钮
    [self setUpTheAddBtn];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[PSDrawerManager sharedInstance] beginDragResponse];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[PSDrawerManager sharedInstance] resetShowType:PSDrawerManagerShowCenter];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[PSDrawerManager sharedInstance] resetShowType:PSDrawerManagerShowCenter];
}

-(void)leftButtonClick
{
    [[PSDrawerManager sharedInstance] resetShowType:PSDrawerManagerShowLeft];
}

- (void)setUpTheAddBtn{
    UIButton * btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 25;
    btn.clipsToBounds = YES;
    [btn.titleLabel setText:@"+"];
    
    __weak typeof(self) weakSelf =self;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).with.mas_offset(@-20);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@50);
        make.centerX.equalTo(weakSelf.view);
    }];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)btn{
    ChooseFoodTypeController *vc = [[ChooseFoodTypeController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)setUpButtons{
    
    
}

- (void)setUpTheScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenBoundsWidth, ScreenBoundsHeight-64)];
//    _scrollView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    [_scrollView setScrollEnabled:YES];
    
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenBoundsWidth, 1080)];
    _grayView.backgroundColor = [UIColor zx_colorWithHexString:@"EEEEEE"];
//    [UIColor colorWithHexString:@"#EEEEEE"];
    
    // 隐藏水平滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    
    [_scrollView addSubview:_grayView];
    
    _preview = [[PreviewView alloc] init];
    _preview.backgroundColor = [UIColor whiteColor];
    [_grayView addSubview:_preview];
    
    __weak typeof(self) weakSelf = self ;
    [self.preview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.grayView).with.offset(0);
        make.left.equalTo(weakSelf.grayView).with.offset(0);
        make.right.equalTo(weakSelf.grayView).with.offset(-0);
        make.centerX.equalTo(self.grayView);
        make.height.mas_equalTo(@206);
    }];
    
    _footTableView = [[FootTableView alloc] initWithFrame:CGRectMake(0, 300, ScreenBoundsWidth, 300) style:UITableViewStyleGrouped];
    [_footTableView registerTheTableViewHeight:^(double height) {
        NSLog(@"%f",height);
        [weakSelf.footTableView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(@(height));
        }];
    }];
    [_grayView addSubview:_footTableView];
    
    _footTableView.layer.cornerRadius = 0;
    
    [self.footTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.preview.mas_bottom).with.offset(14);
        make.left.equalTo(weakSelf.grayView).with.offset(20);
        make.right.equalTo(weakSelf.grayView).with.offset(-20);
        make.height.mas_equalTo(@0);
    }];
    
}





-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    self.scrollView.contentSize = CGSizeMake(712,1000);
//    _scrollView.contentSize = CGSizeMake(ScreenBoundsWidth, ScreenBoundsHeight *2 );
    self.scrollView.contentSize = CGSizeMake(ScreenBoundsWidth,1000);
}

//- (void)updateViewConstraints
//{
//    if (!self.didSetupConstraints) {
//        self.didSetupConstraints = YES;
//        
//        
//    }
//    
//    [super updateViewConstraints];
//}


// 是否支持滑动至顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
