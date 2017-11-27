//
//  ZXShareTool.m
//  TopHot
//
//  Created by Liushannoon on 16/2/2.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#define kShareAppSinaText @"头号健身 - 上头号，约健他, 点击跳转AppStore下载 https://itunes.apple.com/us/app/toho/id1060970447?l=zh&ls=1&mt=8"
#define kShareAppTitle @"头号健身"
#define kShareAppText @"头号健身 - 上头号，约健他, 点击跳转AppStore下载"
#define kShareAppURL @"https://itunes.apple.com/us/app/toho/id1060970447?l=zh&ls=1&mt=8"
#define kAppKey @"1060970447"

#import "ZXShareTool.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "UIImage+ZXExtension.h"

@implementation ZXShareTool

ZXSingletonM(ShareTool)

/**
 *  分享功能 
    过期
 */
- (void)zx_shareAppToFriends
{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImage"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"点击跳转AppStore下载"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"https://itunes.apple.com/us/app/toho/id1060970447?l=zh&ls=1&mt=8"]
                                          title:@"头号健身 - 上头号，约健他"
                                           type:SSDKContentTypeAuto];
        
        // 可以定制不同平台分享的内容,新浪微博的网页链接,需要写到内容中,那个url参数没用
        [shareParams SSDKSetupSinaWeiboShareParamsByText:@"头号健身 - 上头号，约健他, 点击跳转AppStore下载 https://itunes.apple.com/us/app/toho/id1060970447?l=zh&ls=1&mt=8"
                                                   title:@"头号健身"
                                                   image:@[[UIImage imageNamed:@"bg_img"]]
                                                     url:[NSURL URLWithString:@"https://itunes.apple.com/us/app/toho/id1060970447?l=zh&ls=1&mt=8"]
                                                latitude:22.02454411766735
                                               longitude:112.76367125000003
                                                objectID:@"分享"
                                                    type:SSDKContentTypeImage];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                                                         items:nil
                                                                   shareParams:shareParams
                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                               [self zx_handleFinishShareState:state error:error];
                                                           }];
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    }
}

/**
 *  传递要分享的单图过来,进行分享
 *
 *  @param contentImage 要分享的图片
 */
- (void)zx_shareImage:(UIImage *)contentImage
{
    if (contentImage == nil) {
        return;
    }
    NSArray* imageArray = @[contentImage];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:nil
                                         images:imageArray
                                            url:nil
                                          title:@"头号健身"
                                           type:SSDKContentTypeImage];
        
        [shareParams SSDKSetupSinaWeiboShareParamsByText:@"头号健身 - 上头号，约健他"
                                                   title:@"头号健身"
                                                   image:imageArray
                                                     url:nil
                                                latitude:0.0
                                               longitude:0.0
                                                objectID:nil
                                                    type:SSDKContentTypeImage];
        
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            [self zx_handleFinishShareState:state error:error];
        }];
        // 移除编辑页面,直接分享
        //        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    }
}

/**
 *  无UI,直接调用分享代码的分享
 *
 *  @param platformType 平台
 *  @param text         text
 *  @param title        title
 *  @param image        图片
 *  @param url          url
 */
- (void)zx_shareImageToPlatformType:(ZXSharePlatformType)platformType byText:(NSString *)text title:(NSString *)title contentImage:(UIImage *)contentImage url:(NSURL *)url
{
    if (contentImage == nil) {
        return;
    }
    switch (platformType) {
            // qq好友
        case ZXSharePlatformTypeQQFriend:
        {
            //创建分享参数
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:text
                                             images:@[contentImage] //传入要分享的图片
                                                url:url
                                              title:title
                                               type:SSDKContentTypeAuto];
            
            //进行分享
            [ShareSDK share:SSDKPlatformSubTypeQQFriend //传入分享的平台类型
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
                 [self zx_handleFinishShareState:state error:error];
             }];
        }
            break;
            // qq空间 , 必须文本,url,图片都有,点击图片,会跳转到链接,所以需要h5支持
        case ZXSharePlatformTypeQZone:
        {
            //创建分享参数
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:((text == nil) ? (@"头号健身 - 上头号，约健他") : text)
                                             images:@[contentImage] //传入要分享的图片
                                                url:((url == nil) ? [NSURL URLWithString:@"https://itunes.apple.com/us/app/toho/id1060970447?l=zh&ls=1&mt=8"] : url)
                                              title:((title == nil) ? @"头号健身" : title)
                                               type:SSDKContentTypeAuto];
            
            //进行分享
            [ShareSDK share:SSDKPlatformSubTypeQZone //传入分享的平台类型
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
                 [self zx_handleFinishShareState:state error:error];
                 
             }];
        }
            break;
            // 新浪微博
        case ZXSharePlatformTypeSinaWeibo:
        {
            //创建分享参数
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:((text == nil) ? (@"头号健身 - 上头号，约健他") : text)
                                             images:@[contentImage] //传入要分享的图片
                                                url:url
                                              title:((title == nil) ? @"头号健身" : title)
                                               type:SSDKContentTypeAuto];
            
            //进行分享
            [ShareSDK share:SSDKPlatformTypeSinaWeibo //传入分享的平台类型
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
                 [self zx_handleFinishShareState:state error:error];
                 
             }];
            
        }
            break;
            // 微信朋友圈
        case ZXSharePlatformTypeWechatTimeline:
        {
            //创建分享参数
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            // 定制微信好友的分享内容
            [shareParams SSDKSetupWeChatParamsByText:text title:title url:url thumbImage:[contentImage zx_thumbnailWithMaxLong:100] image:contentImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
            
            //进行分享
            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline //传入分享的平台类型
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
                 [self zx_handleFinishShareState:state error:error];
                 
             }];
        }
            break;
            // 微信好友 分享需要制定缩略图的
        case ZXSharePlatformTypeWechatSession:
        {
            //创建分享参数
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            // 定制微信好友的分享内容
            [shareParams SSDKSetupWeChatParamsByText:text title:title url:url thumbImage:[contentImage zx_thumbnailWithMaxLong:100] image:contentImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];
            
            //进行分享
            [ShareSDK share:SSDKPlatformSubTypeWechatSession //传入分享的平台类型
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
                 [self zx_handleFinishShareState:state error:error];
             }];
        }
            break;
        default:
            break;
    }
}

/**
 *  分享单图到指定的平台
 *
 *  @param platformType 要分享的目的平台
 *  @param contentImage 要分享的图片
 */
- (void)zx_shareImageToPlatformType:(ZXSharePlatformType)platformType contentImage:(UIImage *)contentImage
{
    [self zx_shareImageToPlatformType:platformType byText:nil title:nil contentImage:contentImage url:nil];
}

/**
 *  V3.3.1 重构分享app代码
 *
 *  @param platformType 分享app的下载链接到指定平台
 */
- (void)zx_shareAppWithPlatformType:(ZXSharePlatformType)platformType
{
    if (platformType == ZXSharePlatformTypeSinaWeibo) {
        [[ZXShareTool sharedShareTool] zx_shareImageToPlatformType:platformType byText:kShareAppSinaText title:kShareAppTitle contentImage:[UIImage imageNamed:@"shareImage"] url:[NSURL URLWithString:kShareAppURL]];
    } else{
        [[ZXShareTool sharedShareTool] zx_shareImageToPlatformType:platformType byText:kShareAppText title:kShareAppTitle contentImage:[UIImage imageNamed:@"shareImage"] url:[NSURL URLWithString:kShareAppURL]];
    }
}

/**
 *  对分享结果进行处理
 */
- (void)zx_handleFinishShareState:(SSDKResponseState)state error:(NSError *)error
{
    switch (state) {
        case SSDKResponseStateSuccess:
        {
            [ZXProgressHUD showMBTip:@"分享成功" ];
            break;
        }
        case SSDKResponseStateCancel:
        {
            [ZXProgressHUD showMBTip:@"取消分享"];
            break;
        }
        case SSDKResponseStateFail:
        {
            [ZXProgressHUD showMBTip:@"分享失败" ];

            break;
        }
        default:
            break;
    }
}

#pragma mark    -   跳转到AppStore评分

/**
 *  跳转到AppStore评分
 */
- (void)zx_jumpTOAppStore
{
    /**
     *  去软件首页
     */
    NSString *str2 = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@", kAppKey];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str2]];
}

@end
