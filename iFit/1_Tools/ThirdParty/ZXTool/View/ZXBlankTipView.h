//
//  ZXBlankTipView.h
//  EhangGhost2
//
//  Created by Liushannoon on 16/8/10.
//  Copyright © 2016年 lyushuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXTool.h"

@interface ZXBlankTipView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;
/** 点击提示图的回调block */
@property (nonatomic , copy) MyVoidBlock tapBlock;

+ (instancetype)BlankTipViewWithImage:(UIImage *)image tipTitle:(NSString *)tipTitle;
- (void)showImage:(UIImage *)image tipTitle:(NSString *)tipTitle;

@end
