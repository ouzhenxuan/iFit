//
//  UIScrollView+ZXExtension.h
//  EhangGhost2
//
//  Created by ehang on 16/9/20.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ZXExtension)

@property (assign, nonatomic) CGFloat zx_insetT;
@property (assign, nonatomic) CGFloat zx_insetB;
@property (assign, nonatomic) CGFloat zx_insetL;
@property (assign, nonatomic) CGFloat zx_insetR;

@property (assign, nonatomic) CGFloat zx_offsetX;
@property (assign, nonatomic) CGFloat zx_offsetY;

@property (assign, nonatomic) CGFloat zx_contentW;
@property (assign, nonatomic) CGFloat zx_contentH;

@end
