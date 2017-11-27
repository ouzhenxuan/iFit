//
//  ZXShareTool.h
//  TopHot
//
//  Created by Liushannoon on 16/2/2.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXTool.h"

/**
 *  平台类型
 */
typedef NS_ENUM(NSUInteger, ZXSharePlatformType){
    /**
     *  微信好友
     */
    ZXSharePlatformTypeWechatSession    = 1,
    /**
     *  微信朋友圈
     */
    ZXSharePlatformTypeWechatTimeline   = 2,
    /**
     *  QQ好友
     */
    ZXSharePlatformTypeQQFriend         = 3,
    /**
     *  QQ空间
     */
    ZXSharePlatformTypeQZone            = 4,
    /**
     *  新浪微博
     */
    ZXSharePlatformTypeSinaWeibo        = 5,
    ZXSharePlatformTypeFacebook         =6,
};

@interface ZXShareTool : NSObject
/**
 *  获取单例对象
 */
+ (instancetype)sharedShareTool;

/**
 *  分享AppStore下载链接的功能 , ShareSDK的原生UI
 */
- (void)zx_shareAppToFriends;
/**
 *  V2.0 传递要分享的单图过来,进行分享 , 显示的默认UI:ShareSDK的原生UI
 *
 *  @param contentImage 要分享的图片
 */
- (void)zx_shareImage:(UIImage *)contentImage ;

/**
 *  直接调用代码分享,不会出现默认UI , 分享单图到指定的平台
 *
 *  @param platformType 要分享的目的平台
 *  @param contentImage 要分享的图片
 */
- (void)zx_shareImageToPlatformType:(ZXSharePlatformType)platformType contentImage:(UIImage *)contentImage;
/**
 *  无UI,直接调用分享代码的分享
 *
 *  @param platformType 平台
 *  @param text         text
 *  @param title        title
 *  @param image        图片
 *  @param url          url
 */
- (void)zx_shareImageToPlatformType:(ZXSharePlatformType)platformType byText:(NSString *)text title:(NSString *)title contentImage:(UIImage *)contentImage url:(NSURL *)url;
/**
 *  V3.3.1 重构分享app代码
 *
 *  @param platformType 分享app的下载链接到指定平台
 */
- (void)zx_shareAppWithPlatformType:(ZXSharePlatformType)platformType;

#pragma mark    -   跳转到AppStore评分

/**
 *  跳转到AppStore评分
 */
- (void)zx_jumpTOAppStore;

@end
