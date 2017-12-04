//
//  ZXTool.h
//  ZXTool
//
//  Created by Liushannoon on 16/8/10.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "UIColor+ZXExtension.h"
#import "NSDate+ZXExtension.h"
#import "NSString+ZXExtension.h"
#import "UIView+ZXExtension.h"
#import "NSArray+Log.h"
#import "UIImage+ZXExtension.h"
#import "UIScrollView+ZXExtension.h"
#import "UIImageView+ZXExtension.h"

#import "ZXGCDTimer.h"
#import "ZXBottomMultiPurposeView.h"
#import "EHAPI_ZX.h"


#define ZXSystemFont(font) [UIFont systemFontOfSize:font]
#define ZXSystemBlodFont(font) [UIFont boldSystemFontOfSize:font]
#define ZXRootViewController [UIApplication sharedApplication].windows.firstObject.rootViewController
#define ZXUserDefaults [NSUserDefaults standardUserDefaults]
#define ZXDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
#define ZXNoteCenter [NSNotificationCenter defaultCenter]
#define ZXCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define ZXAlertView(messageString , cancelTitle) [[[UIAlertView alloc] initWithTitle:nil message:messageString delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil] show]
#define ZXAlertViewShow(messageString , cancelTitle) ZXAlertView(messageString , cancelTitle)

/**************************************/
/************     控制输出       **********/


#define ZXLogFunc ZXLog(@"%s",__func__)

#ifdef DEBUG
#define ZXLog(...) NSLog(__VA_ARGS__)
#define ZXFormatDebug 0
//#define NSLog(...) NSLog
#else
#define ZXLog(...)
#define ZXFormatDebug 0
#endif

#if ZXFormatDebug
#define ZXFormatLog(...)\
{\
NSString *string = [NSString stringWithFormat:__VA_ARGS__];\
NSLog(@"\n===========================\n===========================\n=== ZXFormatLog ===\n提示信息:%@\n所在方法:%s\n所在行数:%d\n===========================\n===========================",string,__func__,__LINE__);\
}\

#else
#define ZXFormatLog(...)
#endif


/**************************************/
/************     单例       **********/
// 单例.h文件
#define ZXSingletonH(name) + (instancetype)shared##name;
// 单例.m文件
#define ZXSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}\


/**************************************/
/************     dispatch       **********/

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define ZXLock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define ZXUnlock() dispatch_semaphore_signal(self->_lock)
//#define ZXSpinLock(...) OSSpinLockLock(&_lock); \
//__VA_ARGS__; \
//OSSpinLockUnlock(&_lock);//_lock = OS_SPINLOCK_INIT;


/**************************************/
/************     block       **********/
/**
 *  没有参数的block
 */
typedef void(^MyVoidBlock)();
typedef void(^ZXNoParamBlock)();
/**
 *  带有一个NSInteger参数的block
 */
typedef void(^MyNSIntegerBlock)(NSInteger);
typedef void(^ZXIntegerBlock)(NSInteger);



/**************************************/
/************     常量       **********/
#define  kTimeOut 10
