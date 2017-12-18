//
//  ChooseFoodTypeController.m
//  iFit
//
//  Created by 区振轩 on 2017/11/27.
//  Copyright © 2017年 区振轩. All rights reserved.
//
#define kOffsetY ((ScreenBoundsHeight - 275))
#define columns  3;

#import "ChooseFoodTypeView.h"
#import "ChooseFoodTypeView.h"
#import "UIView+ZXExtension.h"
#import "UIColor+HexColor.h"

@interface ChooseFoodTypeView ()
@property (nonatomic,strong) UIButton * breakfastBtn;
@property (nonatomic,strong) UIButton * lunchBtn;
@property (nonatomic,strong) UIButton * dinnerBtn;
@property (nonatomic,strong) UIButton * snackBtn;
@property (nonatomic,strong) UIButton * waterBtn;
@property (nonatomic,strong) UIButton * cancelButton;

@property (nonatomic,strong) NSArray * buttons;
@end

@implementation ChooseFoodTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        UIView * backGroudView = [[UIView alloc] initWithFrame:ZXScreenBounds];
        [self addSubview: backGroudView];
        backGroudView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        backGroudView.alpha = 0.98;
        _breakfastBtn = [[UIButton alloc] init];
        _lunchBtn = [[UIButton alloc] init];
        _dinnerBtn = [[UIButton alloc] init];
        _snackBtn = [[UIButton alloc] init];
        _waterBtn = [[UIButton alloc] init];
        _buttons = @[_breakfastBtn,_lunchBtn,_dinnerBtn,_snackBtn,_waterBtn];

        [self setTheCancelBtn];
        
        [self setBtnUI];
        [self setBtnFrame];
        for (UIButton * btn  in _buttons) {
            [self addSubview:btn];
        }
    }
    
    
//    [self showAnimation];
    return self;
}

- (void) setTheCancelBtn{
    _cancelButton = [[UIButton alloc] init];
    _cancelButton.backgroundColor = [UIColor yellowColor];
    [self addSubview:_cancelButton];
    _cancelButton.layer.cornerRadius = 25;
    _cancelButton.clipsToBounds = YES;
    
    _cancelButton.titleLabel.font = [UIFont fontWithName:@"IconFont" size:20];
    [_cancelButton setTitle:@"\U0000e60e" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_cancelButton.titleLabel setTextColor:[UIColor blackColor]];
    _cancelButton.transform = CGAffineTransformMakeRotation(M_PI_4);
    __weak typeof(self) weakSelf =self;
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).with.mas_offset(@-20);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@50);
        make.centerX.equalTo(weakSelf);
    }];
    [_cancelButton addTarget:self action:@selector(cancelBtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) setBtnUI{
    [_breakfastBtn setImage:[UIImage imageNamed:@"breakfast"] forState:UIControlStateNormal];
    [_lunchBtn setImage:[UIImage imageNamed:@"lunch"] forState:UIControlStateNormal];
    [_dinnerBtn setImage:[UIImage imageNamed:@"dinner"] forState:UIControlStateNormal];
    [_snackBtn setImage:[UIImage imageNamed:@"snack"] forState:UIControlStateNormal];
    [_waterBtn setImage:[UIImage imageNamed:@"sport"] forState:UIControlStateNormal];
}

- (void) setBtnFrame{
    CGFloat top = 275;
    CGFloat leftMargin = 35;
    CGFloat landscapeInsetMargin = 45;
    CGFloat portraitInsetMargin = 34;
    CGFloat buttonWidth = (ScreenBoundsWidth - leftMargin * 2 - landscapeInsetMargin * 2 ) / 3.0;
    CGFloat buttonHeight = buttonWidth + 22;
    int row = 0;
    int column = 0;
    for (int i = 0; i <self.buttons.count; i++) {
        UIButton *tempButton = self.buttons[i];
        row = i / columns;
        column = i % columns;
        tempButton.frame = CGRectMake(leftMargin + (buttonWidth + landscapeInsetMargin) * column, top + row * (buttonHeight + portraitInsetMargin)  + kOffsetY, buttonWidth, buttonHeight);
    }
}

- (void)showAnimation
{
//    self.cancelButton.zx_y = ZXScreenH;
    
    for (int i = 0; i < self.buttons.count; i ++) {
        UIButton *button = self.buttons[i];
        button.alpha = 0.0;
        [UIView animateWithDuration:0.4 delay: i * 0.05 usingSpringWithDamping:0.7 + 0.03 * i initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction  animations:^{
            button.transform = CGAffineTransformMakeTranslation(0, - kOffsetY);
            button.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            if (i == 2) {
                [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//                    self.cancelButton.zx_y = ZXScreenH - self.cancelButton.zx_height - 37;
                    
                } completion:^(BOOL finished) {

                }];
            }
        }];
        
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        _cancelButton.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    }];
    
}

- (void)dismissAnimation
{
    //    self.cancelButtonBottonConstraint.constant = xl_scaleInY_iPhone6(0);
    //    self.tipButton.hidden = YES;
//    _cancelButton.transform = CGAffineTransformMakeRotation(90);
    [UIView animateWithDuration:0.15 animations:^{
        self.cancelButton.zx_y = ZXScreenH;
    }];
    for (NSInteger i = self.buttons.count - 1; i >= 0; i --) {
        UIButton *button = self.buttons[i];
        [UIView animateWithDuration:0.2 delay:0.05 * (self.buttons.count - 1 - i) options:UIViewAnimationOptionAllowUserInteraction animations:^{
            button.transform = CGAffineTransformMakeTranslation(0, kOffsetY);
        } completion:^(BOOL finished) {
            button.alpha = 0.0;
        }];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.15 + 0.04 * self.buttons.count) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cancelButton.transform = CGAffineTransformMakeRotation(M_PI_2);
        [self removeFromSuperview];
    });
}

- (void)cancelBtnClickEvent:(UIButton * )btn{
    [self dismissAnimation];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
