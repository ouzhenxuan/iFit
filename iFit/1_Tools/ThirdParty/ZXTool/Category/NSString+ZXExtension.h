//
//  NSString+ZXExtension.h
//  TopHot
//
//  Created by Liushannoon on 15/12/23.
//  Copyright © 2015年 Liushannoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSDate+ZXExtension.h"

@interface NSString (ZXExtension)

#pragma mark    -   文本处理相关 ,例如:文本高度宽度计算

/**
 *  返回符合条件的文本的高度
 *
 *  @param fontSize       文本字体大小
 *  @param sizeWidth  文本范围的宽度,根据这个宽度和文本内容,计算高度
 *  @param expandDict 预留参数
 *
 *  @return 高度
 */
- (CGFloat)zx_stringHeightWithFontOfSize:(NSInteger)font sizeWidth:(CGFloat)sizeWidth lineSpace:(CGFloat)lineSpace kernSpace:(CGFloat)kernSpace expand:(NSDictionary *)expandDict;
- (CGFloat)zx_stringWidthWithFontOfSize:(NSInteger)fontSize sizeHeight:(CGFloat)sizeHeight lineSpace:(CGFloat)lineSpace kernSpace:(CGFloat)kernSpace  Expand:(NSDictionary *)expandDict;
- (CGFloat)zx_stringHeightWithFontOfSize:(NSInteger)font sizeWidth:(CGFloat)sizeWidth;

#pragma mark    -   日期相关方法

/**
 *  一个时间戳字符串,调用这个方法,返回去一个2015-11-24 20:57:38格式的日期
 *
 *  @param timeInterval 从1970年开始的时间戳
 *
 *  @return 返回去的是一个2015-11-24 20:57:38格式的的时间字符串
 */
- (NSString *)zx_dateString;
/**
 *  对时间戳字符串进行指定格式的转换,返回一个指定格式的日期时间字符串
 *
 *  @param dateFormatType 参数是dateFormatType类型
 *
 *  @return 返回去的是一个指定时间格式的的时间字符串
 */
- (NSString *)zx_dateStringWithDateFormatType:(ZXDateForMatType)dateFormatType;
/**
 *  时间戳字符串转NSDate对象
 *
 *  @return 返回NSDate对象
 */
- (NSDate *)zx_date;
/**
 *  根据时间间距,动态调整时间
 */
- (NSString *)zx_customDateString;
/**
 *  对日期格式的字符串转化为时间戳
 *
 *  @param dateFormat 日期格式
 *
 *  @return 时间戳
 */
- (NSTimeInterval)zx_timeIntervalDateFormat:(ZXDateForMatType)dateFormat;

#pragma mark    -   图文混排

/**
 *  生成一个文字和图片混合的富文本字符串
 *
 *  @param title        文本
 *  @param titleColor   文本颜色
 *  @param titleFont    文本字体大小
 *  @param image        图片
 *  @param isTitleFirst 图片在前还是文字在前
 *
 *  @return 图文混排的富文本
 */
+ (NSAttributedString *)zx_titleAndImageAttributedStringWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)titleFont alignment:(NSTextAlignment)alignment image:(UIImage *)image isTitleFirst:(BOOL)isTitleFirst;
/**
 *  返回指定格式的富文本字符串
 *
 *  @param fontSize 字体size
 *
 *  @return 富文本字符串
 */
- (NSMutableAttributedString *)zx_formatAttributedStringWithFontOfSize:(NSInteger)fontSize;
- (NSMutableAttributedString *)zx_formatAttributedStringWithFontOfSize:(NSInteger)fontSize lineSpace:(CGFloat)lineSpace kernSpace:(CGFloat)kernSpace color:(UIColor *)color;

#pragma mark    -   other

/**
 *  是否为中文系统
 *
 *  @return @"0" - 不是 ;  @"1" - > 是
 */
+ (NSString *)isChineseLanguage;

- (BOOL)zx_containsEmoji;

#pragma mark    -   正则匹配相关

/**
 匹配是否全是数字

 @return yes表示字符串全是0-9数字组成,反之为NO
 */
- (BOOL)zx_checkAllNumber;

@end
