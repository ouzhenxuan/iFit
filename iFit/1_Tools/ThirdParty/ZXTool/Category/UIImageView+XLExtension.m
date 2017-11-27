//
//  UIImageView+ZXExtension.m
//  EhangGhost2
//
//  Created by ehang on 2016/9/26.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import "UIImageView+ZXExtension.h"
#import <objc/runtime.h>
#import "ZXTool.h"
#import <ImageIO/ImageIO.h>


@implementation UIImageView (ZXExtension)


static UIEdgeInsets _edgeinsets;

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeinsets = edgeInsets;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self.image drawInRect:CGRectMake(_edgeinsets.left, _edgeinsets.top, rect.size.width - _edgeinsets.left - _edgeinsets.right, rect.size.height - _edgeinsets.top - _edgeinsets.bottom)];
}

-(void)zx_setGifImage:(NSURL *)imageUrl repeatCount:(NSInteger)repeatCount complecteBlock:(completedBlock)imageCompleteBlock
{
    // 弱引用,防止循环引用
    __weak typeof(self) weakSelf = self;
    
    [self getGifImageWithUrk:imageUrl returnData:^(NSArray<UIImage *> *imageArray, NSArray<NSNumber *> *timeArray, CGFloat totalTime, NSArray<NSNumber *> *widths, NSArray<NSNumber *> *heights) {
        //添加帧动画
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
        NSMutableArray * times = [[NSMutableArray alloc]init];
        float currentTime = 0;
        //设置每一帧的时间占比
        for (int i=0; i<imageArray.count; i++) {
            [times addObject:[NSNumber numberWithFloat:currentTime/totalTime]];
            currentTime+=[timeArray[i] floatValue];
        }
        [animation setKeyTimes:times];
        [animation setValues:imageArray];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        //设置循环
        animation.repeatCount= repeatCount;
        animation.duration = totalTime;
        animation.beginTime = CACurrentMediaTime();
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [[(UIImageView *)weakSelf layer] addAnimation:animation forKey:@"gifAnimation"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((totalTime * repeatCount )* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (imageCompleteBlock) {
                imageCompleteBlock();
            }
        });
    }];
}

/**
 *  传递一个gif图的url , 播放gif图
 *
 *  @param imageUrl gif图的url
 */
-(void)zx_setGifImage:(NSURL *)imageUrl
{
    [self zx_setGifImage:imageUrl repeatCount:MAXFLOAT complecteBlock:^(){
        ZXLog(@"gif播放完毕");
    }];
}

//解析gif文件数据的方法 block中会将解析的数据传递出来
-(void)getGifImageWithUrk:(NSURL *)url
               returnData:(void(^)(NSArray<UIImage *> * imageArray,
                                   NSArray<NSNumber *>*timeArray,
                                   CGFloat totalTime,
                                   NSArray<NSNumber *>* widths,
                                   NSArray<NSNumber *>* heights))dataBlock{
    //通过文件的url来将gif文件读取为图片数据引用
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    //获取gif文件中图片的个数
    size_t count = CGImageSourceGetCount(source);
    //定义一个变量记录gif播放一轮的时间
    float allTime=0;
    //存放所有图片
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    //存放每一帧播放的时间
    NSMutableArray * timeArray = [[NSMutableArray alloc]init];
    //存放每张图片的宽度 （一般在一个gif文件中，所有图片尺寸都会一样）
    NSMutableArray * widthArray = [[NSMutableArray alloc]init];
    //存放每张图片的高度
    NSMutableArray * heightArray = [[NSMutableArray alloc]init];
    //遍历
    for (size_t i=0; i<count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        [imageArray addObject:(__bridge UIImage *)(image)];
        CGImageRelease(image);
        //获取图片信息
        NSDictionary * info = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        CGFloat width = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelWidth] floatValue];
        CGFloat height = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelHeight] floatValue];
        [widthArray addObject:[NSNumber numberWithFloat:width]];
        [heightArray addObject:[NSNumber numberWithFloat:height]];
        NSDictionary * timeDic = [info objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        CGFloat time = [[timeDic objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime] floatValue] / 2;
        allTime+=time;
        [timeArray addObject:[NSNumber numberWithFloat:time]];
    }
    CFRelease(source);
    dataBlock(imageArray,timeArray,allTime,widthArray,heightArray);
}

- (void)zx_setGifImageWithGIFName:(NSString *)gifName
{
    NSData *data = [self zx_getGifImageDataWithGifName:gifName];
    
    if (!data) { // 读取不到gif图
        self.image = [UIImage imageNamed:gifName];
        return;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    
    if (count <= 1) {
        self.image = [[UIImage alloc] initWithData:data];
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
        self.animationImages = images;
        self.animationDuration = duration;
        self.animationRepeatCount = MAXFLOAT;
    }
    
    CFRelease(source);
}

/**
 *  获取gif图数据
 */
- (NSData *)zx_getGifImageDataWithGifName:(NSString *)name
{
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        if (data) {
            return data;
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return data;
        }
        
        return nil;
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return data;
        }
        return nil;
    }
}

/**
 *  计算每一帧图片播放时长
 */
- (float)zx_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source
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

@end
