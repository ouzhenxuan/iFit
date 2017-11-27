//
//  UIImage+ZXExtension.h
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  拉伸保护的类型
 */
typedef NS_ENUM(NSUInteger, ZXStretchableType){
    /**
     *  拉伸中心1px
     */
    ZXStretchableTypeCenter = 1,
    /**
     *  最右边1px
     */
    ZXStretchableTypeRight = 2
};

@interface UIImage (ZXExtension)

/**
 *  返回一个原始的图片，不要被渲染成别的颜色，，，用于导航条上的按钮，不被渲染成蓝色
 */
+ (instancetype)zx_imageWithOriginalRenderingImage:(NSString *)imageName;
/**
 *  返回一个原始的图片，不要被渲染成别的颜色，，，用于导航条上的按钮，不被渲染成蓝色或其他按钮内图片
 */
- (instancetype)zx_originalRenderingImage;
/**
 *  返回一个拉伸保护后的图片，这个图片不会因为拉伸而变形，，，传过来一个图片名字，，，修饰以后，返回一张拉伸保护后的图片（只拉伸最中间的那个像素），
 */
+ (instancetype)zx_imageWithStretchableImageName:(NSString *)imageName;
/**
 *  返回一张拉伸保护的图片
 */
//- (instancetype)zx_stretchableImage;
/**
 *  返回一张拉伸最右边一像素的的图片
 */
- (instancetype)zx_stretchableImageWithStretchableType:(ZXStretchableType)stretchableType;

/**
 *  返回一张指定size的指定颜色的纯色图片
 */
+ (UIImage *)zx_imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  返回一张指定size的指定颜色的   圆形非拉伸保护的纯色图片
 */
+ (UIImage *)zx_circleImageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  返回一张指定size的指定颜色的圆形拉伸保护的纯色图片 , size要大于控件的大小
 */
+ (UIImage *)zx_circleAndStretchableImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  返回一张 指定size的 指定颜色的 右下角圆形裁剪的图片
 *
 *  @param color 图片的颜色
 *  @param size  图片的大小
 *
 *  @return 返回一张 指定size的 指定颜色的 右下角圆形裁剪的图片
 */
+ (UIImage *)zx_LowerRightCornercircleImageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  对图片进行右下角的裁剪 , 其他三个角不裁剪
 */
- (UIImage *)zx_LowerRightCornercircleImage;

/**
 * 圆形图片
 */
- (UIImage *)zx_circleImage;
/**
 * 圆形图片 , 带指定颜色 , 制定宽度的边框
 */
- (UIImage *)zx_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  改变图像的尺寸，方便上传服务器
 */
- (UIImage *)zx_scaleToSize:(CGSize)size;
/**
 *  如果图片大于targetLength,把图片压缩至targetLength,用于微信分享缩略图
 *
 *  @param targetLength 目标大小 , 单位是b
 *
 *  @return 返回一个内存占用不大于目标大小的图片
 */
- (UIImage *)zx_scaleToLength:(NSUInteger)targetLength;
/**
 *  保持原来的长宽比，生成一个指定size的缩略图 , 多余部分会是透明色的,图片在此size内居中
 */
- (UIImage *)zx_thumbnailWithScaleSize:(CGSize)scaleSize;
/**
 *  保持原来的长宽比，生成一个指定最大长度(宽 / 高)的缩略图 , 没有空白部分
 *
 *  @param maxLong 生成的缩略图中的长/宽中的最大值,根据图片长宽比例赋值给缩略图的 长/宽
 */
- (UIImage *)zx_thumbnailWithMaxLong:(CGFloat)maxLong;

/**
 *  获取一个图片上面指定区域的图片
 *
 *  @param partRect 截取的rect
 *
 *  @return 返回截取以后的图片
 */
- (UIImage *)zx_getPartImageWithPartRect:(CGRect)partRect;

/**
 *  返回一张有水印的图片
 */
-(UIImage *)zx_imageWithWaterMark;
/**
 *  对图片进行圆角裁剪
 */
- (UIImage *)zx_clipWithCornerRadius:(CGFloat)cornerRadius;

/**
 *  返回一张密码输入框网格图片
 *
 *  @param gridCount 网格数
 *  @param gridLineColor 网格线颜色
 *  @param gridLineWidth 网格线宽度
 *
 *  @return 网格图片
 */
+ (instancetype)zx_passwordInputGridImageWithGridCount:(NSInteger)gridCount gridLineColor:(UIColor *)gridLineColor gridLineWidth:(CGFloat)gridLineWidth;

#pragma mark    Gif

/**
 *  通过UIImage内部方法实现gif图播放
 */
+ (UIImage *)zx_animatedGIFNamed:(NSString *)name;
+ (UIImage *)zx_animatedGIFWithData:(NSData *)data;
- (UIImage *)zx_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
