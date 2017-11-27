//
//  UIImageView+ZXExtension.h
//  EhangGhost2
//
//  Created by ehang on 2016/9/26.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^completedBlock)();

@interface UIImageView (ZXExtension)

//- (void)zx_borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets;

/**
 *  通过CAKeyframeAnimation实现Gif图播放
 *
 *  @param imageUrl gif图的url
 */
-(void)zx_setGifImage:(NSURL *)imageUrl repeatCount:(NSInteger)repeatCount complecteBlock:(completedBlock)imageCompleteBlock;
/**
 *  通过UIImageView自带的动画组实现Gif图播放
 *
 *  @param gifName gif图的名字
 */
- (void)zx_setGifImageWithGIFName:(NSString *)gifName;


@end
