//
//  CircleView.h
//  iFit
//
//  Created by 区振轩 on 2017/9/19.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView


/**
 进度，取值为0-1.0
 */
@property (nonatomic,assign) double progress;
@property (nonatomic,assign) double circleRadius;
@property (nonatomic,assign) CGPoint circleCenter;


- (instancetype)initCircleViewWithRadius:(double)radius Center:(CGPoint)center;

@end
