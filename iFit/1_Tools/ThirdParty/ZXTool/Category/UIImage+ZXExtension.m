//
//  UIImage+ZXExtension.m
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import "UIImage+ZXExtension.h"
#import <ImageIO/ImageIO.h>
#import "ZXTool.h"

@implementation UIImage (ZXExtension)

/**
 *  返回一个原始的图片，不要被渲染成别的颜色，，，用于导航条上的按钮，不被渲染成蓝色
 */

+ (instancetype)zx_imageWithOriginalRenderingImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

/**
 *  返回一个原始的图片，不要被渲染成别的颜色，，，用于导航条上的按钮，不被渲染成蓝色或其他按钮内图片
 */
- (instancetype)zx_originalRenderingImage
{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  返回一个拉伸保护后的图片，这个图片不会因为拉伸而变形，，，传过来一个图片名字，，，修饰以后，返回一张拉伸保护后的图片（只拉伸最中间的那个像素），
 */
+ (instancetype)zx_imageWithStretchableImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

/**
 *  返回一张拉伸保护中心的图片
 */
//- (instancetype)zx_stretchableImage
//{
//    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
//}

/**
 *  返回一张拉伸最右边一像素的的图片
 */
- (instancetype)zx_stretchableImageWithStretchableType:(ZXStretchableType)stretchableType
{
    switch (stretchableType) {
        case ZXStretchableTypeCenter:
        {
            return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
        }
            break;
        case ZXStretchableTypeRight:
        {
            return [self stretchableImageWithLeftCapWidth:(self.size.width - 1) topCapHeight:(self.size.height - 1)];
        }
            break;
            
        default:
        {
            return self;
        }
            break;
    }
    
}

/**
 * 圆形图片
 */
- (UIImage *)zx_circleImage
{
    /**
     * CGSize size 是开启的位图大小，同时也是下面从位图上获取的图片的size
     第二个参数：不透明吗？   设置为 no，表示透明
     第三个参数：缩放比例     一般设置为0.0，(伸缩比例，这个参数搞不懂，貌似设置成1.0也没问题？？？？)
     */
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    //获取当前图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加一个椭圆，第一个参数是在那个上下文上面添加，，，第二个参数是设定一个矩形框，这个椭圆会”填充“这个矩形框，如果这个矩形框是正方形，那么就是圆
    CGRect rect =CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx,rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    //把图片画到指定的地方上
    [self drawInRect:rect];
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭位图
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 * 圆形图片 , 带指定颜色 , 制定宽度的边框
 */
- (UIImage *)zx_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, borderColor.CGColor);
    CGRect rect =CGRectMake(borderWidth,borderWidth, self.size.width - borderWidth * 2, self.size.height - borderWidth * 2);
    CGContextAddEllipseInRect(ctx,rect);
    CGContextClip(ctx);

    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;

}


/**
 *  对图片进行右下角的裁剪 , 其他三个角不裁剪
 */
- (UIImage *)zx_LowerRightCornercircleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x = 0; // 这个是x值
    CGFloat y = 0; // 这个是y
    CGFloat height = self.size.height;
    CGFloat width = self.size.width;
    CGRect rect =CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextMoveToPoint(context, (x + width), y + height/2);  // 开始坐标右边开始
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p2形成一条线的p3,radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, (x + width), (y + height), (x + width / 2), (y + height), height / 2);  // 右下角角度
    CGContextAddLineToPoint(context, x, y + height);
    CGContextAddLineToPoint(context, x, y);
    CGContextAddLineToPoint(context, x+ width, y);
    // 裁剪
    CGContextClip(context);
    //把图片画到指定的地方上
    [self drawInRect:rect];
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭位图
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  对图片进行圆角裁剪
 */
- (UIImage *)zx_clipWithCornerRadius:(CGFloat)cornerRadius
{
    if (self.size.width < self.size.height) {
        cornerRadius = cornerRadius > self.size.width * 0.5 ? self.size.width * 0.5 : cornerRadius;
    } else {
        cornerRadius = cornerRadius > self.size.height * 0.5 ? self.size.height * 0.5 : cornerRadius;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = self.size.height;
    CGFloat width = self.size.width;
    CGRect rect =CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 左上圆角
    CGContextMoveToPoint(context, (x + cornerRadius), y);
    CGContextAddArcToPoint(context, (x ), (y), (x), (y + cornerRadius), cornerRadius);
    
    // 左下圆角
    CGContextAddLineToPoint(context, x, height - cornerRadius);
    CGContextAddArcToPoint(context, x, height, x + cornerRadius, height, cornerRadius);
    
    // 右下圆角
    CGContextAddLineToPoint(context, width - cornerRadius, height);
    CGContextAddArcToPoint(context, width, height, width, height - cornerRadius, cornerRadius);
    
    // 右上圆角
    CGContextAddLineToPoint(context, width, x + cornerRadius);
    CGContextAddArcToPoint(context, width, y, width - cornerRadius, y, cornerRadius);
    
    CGContextAddLineToPoint(context, x + cornerRadius, y);
    
    // 裁剪
    CGContextClip(context);
    //把图片画到指定的地方上
    [self drawInRect:rect];
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭位图
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  改变图像的尺寸，方便上传服务器
 */
- (UIImage *)zx_scaleToSize:(CGSize)size
{
    if (size.width == self.size.width && size.height == self.size.height) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(size ,NO , 1.0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 *  如果图片大于targetLength (单位b,字节),把图片压缩至targetLength,用于微信分享缩略图
 *
 *  @param targetLength 目标大小 , 单位是b
 *
 *  @return 返回一个内存占用不大于目标大小的图片
 */
- (UIImage *)zx_scaleToLength:(NSUInteger)targetLength
{
    NSInteger originalLength = UIImagePNGRepresentation(self).length;
    if ( originalLength > targetLength) {
        if (originalLength <= 0) {
            return self;
        }
        CGFloat scale = sqrt(1.0 * targetLength / originalLength);
        return [self zx_scaleToSize:CGSizeMake(self.size.width * scale, self.size.height * scale)];
    } else {
        return self;
    }
}

/**
 *  保持原来的长宽比，生成一个指定size的缩略图 , 多余部分会是透明色的,图片在此size内居中
 */
- (UIImage *)zx_thumbnailWithScaleSize:(CGSize)scaleSize;
{
    if (scaleSize.width == self.size.width && scaleSize.height == self.size.height) {
        return self;
    }
    UIImage *newimage;
    if (nil == self) {
        newimage = nil;
    } else {
        CGSize oldsize = self.size;
        CGRect rect;
        if (scaleSize.width/scaleSize.height > oldsize.width/oldsize.height) {
            rect.size.width = scaleSize.height*oldsize.width/oldsize.height;
            rect.size.height = scaleSize.height;
            rect.origin.x = (scaleSize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = scaleSize.width;
            rect.size.height = scaleSize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (scaleSize.height - rect.size.height)/2;
        }
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(scaleSize, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (!CGContextIsPathEmpty(context))
        {
            CGContextClip(context);
        }
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, scaleSize.width, scaleSize.height));//clear background
        
        [self drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

/**
 *  保持原来的长宽比，生成一个指定最大长度(宽 / 高)的缩略图 , 没有空白部分
 *
 *  @param maxLong 生成的缩略图中的长/宽中的最大值,根据图片长宽比例赋值给缩略图的 长/宽
 */
- (UIImage *)zx_thumbnailWithMaxLong:(CGFloat)maxLong
{
    CGSize scaleSize;
    if (self == nil || self.size.width == 0 || self.size.height == 0) {
        return nil;
    }
    CGSize originalSize = self.size;
    if (originalSize.width > originalSize.height) {
        scaleSize = CGSizeMake(maxLong, maxLong * originalSize.height / originalSize.width);
    } else {
        scaleSize = CGSizeMake(maxLong * originalSize.width / originalSize.height  , maxLong );
    }
    return [self zx_scaleToSize:scaleSize];
}

/**
 *  获取一个图片上面指定区域的图片
 *
 *  @param partRect 截取的rect
 *
 *  @return 返回截取以后的图片
 */
- (UIImage *)zx_getPartImageWithPartRect:(CGRect)partRect
{
    CGImageRef imageRef = self.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, partRect);
    UIImage *retImg = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return retImg;
}

/**
 *  返回一张有水印的教练
 */
-(UIImage *)zx_imageWithWaterMark
{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    //    UIGraphicsBeginImageContext(<#CGSize size#>)
    //    //获取当前图形上下文
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //
    //    //添加一个椭圆，第一个参数是在那个上下文上面添加，，，第二个参数是设定一个矩形框，这个椭圆会”填充“这个矩形框，如果这个矩形框是正方形，那么就是圆
    CGRect rect =CGRectMake(0, 0, self.size.width, self.size.height);
    //    CGContextAddEllipseInRect(ctx,rect);
    //
    //    // 裁剪
    //    CGContextClip(ctx);
    
    //把图片画到指定的地方上
    [self drawInRect:rect];
    UIImage *waterMarkImage = [UIImage imageNamed:@"watermark_logo"];
    [waterMarkImage drawInRect:CGRectMake(self.size.width - 60 - 134, self.size.height - 60     - 91, 134, 91)];
    
    //获取图片
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭位图
    UIGraphicsEndImageContext();
    
    return imageNew;
}

/**
 *  返回一张指定size的指定颜色的纯色图片
 */
+ (UIImage *)zx_imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (size.width <= 0  ) {
        size = CGSizeMake(3, 3);
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  返回一张指定size的指定颜色的   圆形非拉伸保护的纯色图片
 */
+ (UIImage *)zx_circleImageWithColor:(UIColor *)color size:(CGSize)size
{
    return [[self zx_imageWithColor:color size:size] zx_circleImage];
}

/**
 *  返回一张指定size的指定颜色的圆形拉伸保护的纯色图片
 */
+ (UIImage *)zx_circleAndStretchableImageWithColor:(UIColor *)color size:(CGSize)size
{
    if (size.width <= 1) {
        size.width = 3;
        size.height = 3;
    }
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //获取当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //添加一个椭圆，第一个参数是在那个上下文上面添加，，，第二个参数是设定一个矩形框，这个椭圆会”填充“这个矩形框，如果这个矩形框是正方形，那么就是圆
    CGRect rect =CGRectMake(0, 0, size.width, size.height);
    CGContextAddEllipseInRect(context,rect);
    CGContextClip(context);
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    // 裁剪
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image zx_stretchableImageWithStretchableType:ZXStretchableTypeCenter];
    ;
}

/**
 *  返回一张 指定size的 指定颜色的 右下角圆形裁剪的图片
 *
 *  @param color 图片的颜色
 *  @param size  图片的大小
 *
 *  @return 返回一张 指定size的 指定颜色的 右下角圆形裁剪的图片
 */
+ (UIImage *)zx_LowerRightCornercircleImageWithColor:(UIColor *)color size:(CGSize)size
{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //An opaque type that represents a Quartz 2D drawing environment.
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    /*画圆角矩形*/
    CGFloat x = 0; // 这个是x值
    CGFloat y = 0; // 这个是y
    CGFloat height = size.height;
    CGFloat width = size.width;
    CGContextMoveToPoint(context, (x + width), y + height/2);  // 开始坐标右边开始
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p2形成一条线的p3,radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, (x + width), (y + height), (x + width / 2), (y + height), height / 2);  // 右下角角度
    CGContextAddLineToPoint(context, x, y + height);
    CGContextAddLineToPoint(context, x, y);
    CGContextAddLineToPoint(context, x+ width, y);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill); //根据坐标绘制路径
    
    //获取图片
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭位图
    UIGraphicsEndImageContext();
    
    return imageNew;
}

/**
 *  返回一张密码输入框网格图片
 *
 *  @param gridCount 网格数
 *  @param gridLineColor 网格线颜色
 *  @param gridLineWidth 网格线宽度
 *
 *  @return 网格图片
 */
+ (instancetype)zx_passwordInputGridImageWithGridCount:(NSInteger)gridCount gridLineColor:(UIColor *)gridLineColor gridLineWidth:(CGFloat)gridLineWidth
{
    CGFloat gridWidth = 54;
    CGSize size = CGSizeMake(gridWidth * gridCount, gridWidth);
    
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 画外边框
    CGFloat marginFix = gridLineWidth * 0.5;
    CGContextMoveToPoint(context, marginFix, marginFix);
    CGContextAddLineToPoint(context, size.width - marginFix, marginFix);
    CGContextAddLineToPoint(context, size.width - marginFix, size.height - marginFix);
    CGContextAddLineToPoint(context, marginFix, size.height - marginFix);
    CGContextAddLineToPoint(context, marginFix, marginFix);
    // 画内边框
    for (int i = 1 ; i < gridCount; i ++) {
        CGContextMoveToPoint(context, i * gridWidth, 0);
        CGContextAddLineToPoint(context, i * gridWidth, gridWidth);
    }
    
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    // 设置线条颜色
    [gridLineColor setStroke];
    //设置线条宽度
    CGContextSetLineWidth(context, gridLineWidth);
    //设置连接样式,,,必须要连接在一起的，首位相接的，第二条线的起点不是你用CGContextMoveToPoint自己写的，才有用
    CGContextSetLineJoin(context, kCGLineJoinBevel );
    //设置顶角样式
    CGContextSetLineCap(context, kCGLineCapRound);
    //渲染，线段，图片用rect,后边的参数是渲染方式kCGPathFillStroke,表示既有边框，又有填充；kCGPathFill只填充
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //获取图片
    UIImage *gridImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭位图
    UIGraphicsEndImageContext();
    
    return gridImage;
}

#pragma mark    -   Gif

+ (UIImage *)zx_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    } else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            duration += [self zx_frameDurationAtIndex:i source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:3.0];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

/**
 *  计算每一帧图片播放时长
 *
 *  @param index  <#index description#>
 *  @param source <#source description#>
 *
 *  @return <#return value description#>
 */
+ (float)zx_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source
{
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    } else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

+ (UIImage *)zx_animatedGIFNamed:(NSString *)name
{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [UIImage zx_animatedGIFWithData:data];
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage zx_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage zx_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}

- (UIImage *)zx_animatedImageByScalingAndCroppingToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    } else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    
    NSMutableArray *scaledImages = [NSMutableArray array];
    
    for (UIImage *image in self.images) {
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        [scaledImages addObject:newImage];
        
        UIGraphicsEndImageContext();
    }
    
    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}

@end
