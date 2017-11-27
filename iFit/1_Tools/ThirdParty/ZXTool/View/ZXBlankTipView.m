//
//  ZXBlankTipView.m
//  EhangGhost2
//
//  Created by Liushannoon on 16/8/10.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import "ZXBlankTipView.h"

@implementation ZXBlankTipView

+ (instancetype)BlankTipViewWithImage:(UIImage *)image tipTitle:(NSString *)tipTitle
{
    ZXBlankTipView *tipView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    tipView.tipImageView.image = image;
    tipView.tipImageView.contentMode = UIViewContentModeCenter;
    tipView.tipLabel.text = tipTitle;
    tipView.imageViewHeightConstraint.constant = image.size.height;
    tipView.imageViewWidthConstraint.constant = image.size.width;
    tipView.zx_height = image.size.height + 24;
    tipView.zx_width = ZXScreenW;
    
    [tipView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:tipView action:@selector(clickTipView)]];
    
    return tipView;
}

- (void)showImage:(UIImage *)image tipTitle:(NSString *)tipTitle
{
    self.tipImageView.image = image;
    self.tipLabel.text= tipTitle;
    self.imageViewHeightConstraint.constant = image.size.height;
    self.imageViewWidthConstraint.constant = image.size.width;
    [self layoutIfNeeded];
}

- (void)clickTipView
{
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initial];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initial];
    }
    return self;
}

/**
 *  初始化
 */
- (void)initial
{
    self.tipLabel.text = nil;
    self.tipImageView.image = nil;
    self.tipLabel.font = S3;
    self.tipLabel.textColor = C5;
    
    // 测试插入到uitableView里面以后,按钮的响应不及时刷新UI问题,待解决
//    UIButton *button = [[UIButton alloc] init];
//    [button setBackgroundImage:[UIImage imageNamed:@"btn_3"] forState:UIControlStateNormal];
//    [button setTitle:@"kjadfj``" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(100, 400, 100, 100);
//    [self addSubview:button];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)buttonclick
{
    ZXLogFunc;
}

- (void)updateConstraints
{
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
