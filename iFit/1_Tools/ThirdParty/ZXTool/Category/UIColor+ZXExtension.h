//
//  UIColor+ZXExtension.h
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//
#define ZXRGBAColor(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define ZXRGBColor(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
#define ZXHexColor(HexString) [UIColor zx_colorWithHexString:(HexString)]
#define ZXRandomColor [UIColor zx_randomColor]

#import <UIKit/UIKit.h>

@interface UIColor (ZXExtension)

/**
 * 从十六进制字符串获取颜色，color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *  @param color 从十六进制字符串获取颜色，color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 */
+ (UIColor *)zx_colorWithHexString:(NSString *)color;
/**
 *  从十六进制字符串获取颜色，color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 *  @param color 十六进制字符串
 *  @param alpha 透明度
 *
 *  @return 返回的颜色
 */
+ (UIColor *)zx_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
/**
 *  返回一个随机颜色 , 透明度是1
 */
+ (UIColor *)zx_randomColor;

@end
