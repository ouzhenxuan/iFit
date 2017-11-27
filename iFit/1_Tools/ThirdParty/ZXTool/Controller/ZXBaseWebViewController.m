//
//  ZXBaseWebViewController.m
//  EhangGhost2
//
//  Created by Liushannoon on 16/8/10.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import "ZXBaseWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "MJRefresh.h"
#import "ZXAnimationHeader.h"
#import "ZXBlankTipView.h"

@interface ZXBaseWebViewController ()< NJKWebViewProgressDelegate>

@property (nonatomic , strong) NSString  *urlString;
@property (nonatomic , strong) NJKWebViewProgressView  *progressView;
@property (nonatomic , strong) NJKWebViewProgress *progressProxy;
/** 是否支持下拉刷新 */
@property (nonatomic , assign) BOOL refreshHeader;
/** 加载失败的提醒视图 */
@property (nonatomic , strong) ZXBlankTipView  *blankTipView;

@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *closeItem;
@property (nonatomic , strong) UIBarButtonItem  *negativeSpacer;

@end

@implementation ZXBaseWebViewController

#pragma mark    -   get / set

- (ZXBlankTipView *)blankTipView
{
    if (_blankTipView == nil) {
        _blankTipView = [ZXBlankTipView BlankTipViewWithImage:[UIImage imageNamed:@"reload"] tipTitle:NSLocalizedString(@"网络状态差,点击重新加载", nil)];
        _blankTipView.backgroundColor = (self.view.backgroundColor) ? self.view.backgroundColor : [UIColor whiteColor];
        _blankTipView.tipLabel.font = S2;
        _blankTipView.tipLabel.textColor = C4;
    }
    
    return _blankTipView;
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
    }
    
    return _webView;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    self.progressView.progressBarView.backgroundColor = progressColor;
}

- (void)setProgressHeight:(CGFloat)progressHeight
{
    _progressHeight = progressHeight;
    self.progressView.zx_height = progressHeight;
}

- (void)setTipStringFont:(UIFont *)tipStringFont
{
    _tipStringFont = tipStringFont;
    self.blankTipView.tipLabel.font = tipStringFont;
}

- (void)setTipStringColor:(UIColor *)tipStringColor
{
    _tipStringColor = tipStringColor;
    self.blankTipView.tipLabel.textColor = tipStringColor;
}

- (void)setRefreshHeader:(BOOL)refreshHeader
{
    _refreshHeader = refreshHeader;
    if (refreshHeader) {
        // 添加下拉刷新控件
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        self.webView.scrollView.mj_header = header;
        header.lastUpdatedTimeLabel.hidden = YES;
        [header setTitle:NSLocalizedString(@"下拉刷新",nil) forState:(MJRefreshStateIdle)];
        [header setTitle:NSLocalizedString(@"正在刷新",nil) forState:(MJRefreshStateRefreshing)];
        [header setTitle:NSLocalizedString(@"松手立即刷新",nil) forState:(MJRefreshStatePulling)];
        [header setTitle:NSLocalizedString(@"下拉刷新",nil) forState:(MJRefreshStateWillRefresh)];

    } else {
        self.webView.scrollView.mj_header = nil;
    }
}

#pragma mark    -   initial

- (instancetype)initWithURLString:(NSString *)urlString refreshHeader:(BOOL)refreshHeader failureTipImage:(UIImage *)failureTipImage failureTipString:(NSString *)failureTipString failureTipTapBlock:(MyVoidBlock)failureTipTapBlock
{
    if (self = [super init]) {

        self.urlString = urlString;
        self.blankTipView.tipImageView.image = failureTipImage;
        self.blankTipView.tipLabel.text = failureTipString ;
        self.blankTipView.tapBlock = failureTipTapBlock;
        self.refreshHeader = refreshHeader;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
    self.webView.frame = CGRectMake(0, 0, ZXScreenW, ZXScreenH - 64);
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.scalesPageToFit = YES;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    if (_urlString.length > 0) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    }

    self.blankTipView.frame = self.view.bounds;
    [self.view addSubview:self.blankTipView];
    self.blankTipView.alpha = 0.0;
    
    self.progressView = [[NJKWebViewProgressView alloc] init];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.progressView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), [UIScreen mainScreen].bounds.size.width, 2.0);
    [self.view addSubview:self.progressView];
    [self.progressView setProgress:0.0f animated:YES];
    
    self.navigationItem.leftBarButtonItems = @[self.negativeSpacer,self.backItem];
    
}

#pragma mark    -   private

- (void)loadNewData
{
    [self.webView reload];
}

#pragma mark    -   <UIWebViewDelegate>

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.progressView setProgress:0.0f animated:YES];
    [UIView animateWithDuration:0.15 animations:^{
        self.blankTipView.alpha = 0.0;
    }];
    self.title = NSLocalizedString(@"正在加载...", nil);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.webView.scrollView.mj_header endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.title = NSLocalizedString(@"加载失败", nil);
    [UIView animateWithDuration:0.15 animations:^{
        self.blankTipView.alpha = 1.0;
    }];
    [self.webView.scrollView.mj_header endRefreshing];
}

- (BOOL)webView:(UIWebView *)awebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

#pragma mark - NJKWebViewProgressDelegate

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
}

#pragma mark    -   public

- (void)loadURLWithURLString:(NSString *)string
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
    self.urlString = string;
}

#pragma mark - 关闭按钮处理

//点击返回的方法
- (void)backNative
{
    //判断是否有上一层H5页面
    if ([self.webView canGoBack]) {
        //如果有则返回
        [self.webView goBack];
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
        self.navigationItem.leftBarButtonItems = @[self.negativeSpacer,self.backItem, self.closeItem];
    } else {
        [self closeNative];
    }
}

//关闭H5页面，直接回到原生页面
- (void)closeNative
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - init

- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"返回icon"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backNative) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 0, 40, 40);
        _backItem.customView = btn;
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem
{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"关闭", nil) style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)];
    }
    return _closeItem;
}

- (UIBarButtonItem *)negativeSpacer
{
    if (_negativeSpacer == nil) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        _negativeSpacer = negativeSpacer;
    }
    
    return _negativeSpacer;
}

@end
