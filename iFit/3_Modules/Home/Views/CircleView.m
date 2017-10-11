//
//  CircleView.m
//  iFit
//
//  Created by 区振轩 on 2017/9/19.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "CircleView.h"
#import "LabelNumView.h"
#import "UIColor+HexColor.h"

@interface CircleView ()

@property (nonatomic,strong) LabelNumView * labelNumView;

@end


@implementation CircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.progress = 0.2;
    }
    return self;
}

- (instancetype)initCircleViewWithRadius:(double)radius Center:(CGPoint)center{
    self = [super init];
    if (self) {
        self.circleRadius = radius;
        self.circleCenter = center;
    }
    
    
    [self setUpUI];
    return self;
}

- (void)setUpUI{
    _labelNumView = [[LabelNumView alloc] initViewWithNum:1231 Title:@"目标摄入量"];
    [self addSubview:_labelNumView];
    
    [_labelNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 60));
    }];
    _labelNumView.backgroundColor= [UIColor clearColor];
    _labelNumView.NumFontSize = 40;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文
    [[UIColor clearColor] setFill];
    UIRectFill(rect);
    
    if (self.circleCenter.x == 0 && self.circleCenter.y == 0) {
        self.circleCenter = CGPointMake(70, 70);
    }
    CGPoint center = self.circleCenter;  //设置圆心位置
    CGFloat radius = self.circleRadius;  //设置半径
    CGFloat startA = - M_PI_2;  //圆起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;  //圆终点位置
    
    CGFloat endA1 = -M_PI_2 + M_PI * 2;  //圆终点位置
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA1 clockwise:YES];
    
    CGContextSetLineWidth(ctx, 6); //设置线条宽度
    [[UIColor colorWithHexString:@"#C8C8C834"] setStroke]; //设置描边颜色
    CGContextAddPath(ctx, path1.CGPath); //把路径添加到上下文
    CGContextStrokePath(ctx);  //渲染
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    CGContextSetLineWidth(ctx, 6); //设置线条宽度
    [[UIColor colorWithHexString:@"#282828"] setStroke]; //设置描边颜色
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    CGContextSetLineWidth(ctx, 6); //设置线条宽度
    CGContextSetLineCap(ctx, kCGLineCapRound);//线条圆角样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);//两线之间拐角的样式。
    
    CGContextAddPath(ctx, path.CGPath); //把路径添加到上下文
    
    CGContextStrokePath(ctx);  //渲染
    
}



@end
