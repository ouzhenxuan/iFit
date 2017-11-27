//
//  ZXAnimationHeader.m
//  TopHot
//
//  Created by Liushannoon on 15/11/11.
//  Copyright © 2015年 Liushannoon. All rights reserved.
//

#import "ZXAnimationHeader.h"

@implementation ZXAnimationHeader

#pragma mark - 重写方法
#pragma mark 基本设置
// 动画gif图
//- (void)prepare
//{
//    [super prepare];
//    
//    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=30; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"load%02zd", i]];
//        [idleImages addObject:image];
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
//    
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=30; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"load%02zd", i]];
//        [refreshingImages addObject:image];
//    }
//    
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
//    
//    // 设置正在刷新状态的动画图片
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
//    
//    self.lastUpdatedTimeLabel.hidden = YES;
//    self.stateLabel.hidden = YES;
//}

- (void)prepare
{
    [super prepare];
    
    //    self.stateLabel.backgroundColor = [UIColor redColor];
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    self.stateLabel.textColor = ZXHexColor(@"999999");
}

@end
