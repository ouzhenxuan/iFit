//
//  UIScrollView+ZXExtension.m
//  EhangGhost2
//
//  Created by ehang on 16/9/20.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import "UIScrollView+ZXExtension.h"

@implementation UIScrollView (ZXExtension)

- (void)setXl_insetT:(CGFloat)zx_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = zx_insetT;
    self.contentInset = inset;
}

- (CGFloat)zx_insetT
{
    return self.contentInset.top;
}

- (void)setXl_insetB:(CGFloat)zx_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = zx_insetB;
    self.contentInset = inset;
}

- (CGFloat)zx_insetB
{
    return self.contentInset.bottom;
}

- (void)setXl_insetL:(CGFloat)zx_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = zx_insetL;
    self.contentInset = inset;
}

- (CGFloat)zx_insetL
{
    return self.contentInset.left;
}

- (void)setXl_insetR:(CGFloat)zx_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = zx_insetR;
    self.contentInset = inset;
}

- (CGFloat)zx_insetR
{
    return self.contentInset.right;
}

- (void)setXl_offsetX:(CGFloat)zx_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = zx_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)zx_offsetX
{
    return self.contentOffset.x;
}

- (void)setXl_offsetY:(CGFloat)zx_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = zx_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)zx_offsetY
{
    return self.contentOffset.y;
}

- (void)setXl_contentW:(CGFloat)zx_contentW
{
    CGSize size = self.contentSize;
    size.width = zx_contentW;
    self.contentSize = size;
}

- (CGFloat)zx_contentW
{
    return self.contentSize.width;
}

- (void)setXl_contentH:(CGFloat)zx_contentH
{
    CGSize size = self.contentSize;
    size.height = zx_contentH;
    self.contentSize = size;
}

- (CGFloat)zx_contentH
{
    return self.contentSize.height;
}

@end
