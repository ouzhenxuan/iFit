//
//  ChooseFoodTypeView.m
//  iFit
//
//  Created by 区振轩 on 2017/11/22.
//  Copyright © 2017年 区振轩. All rights reserved.
//
#define kOffsetY ((ScreenBoundsHeight - 275) * 0.5)
#define columns  3;

#import "ChooseFoodTypeView.h"

@interface ChooseFoodTypeView()
@property (nonatomic,strong) UIButton * breakfastBtn;
@property (nonatomic,strong) UIButton * lunchBtn;
@property (nonatomic,strong) UIButton * dinnerBtn;
@property (nonatomic,strong) UIButton * snackBtn;
@property (nonatomic,strong) UIButton * waterBtn;

@property (nonatomic,strong) NSArray * buttons;
@end

@implementation ChooseFoodTypeView

- (instancetype)init{
    self = [super init];
    if (self) {
        _breakfastBtn = [[UIButton alloc] init];
        _lunchBtn = [[UIButton alloc] init];
        _dinnerBtn = [[UIButton alloc] init];
        _snackBtn = [[UIButton alloc] init];
        _waterBtn = [[UIButton alloc] init];
        
        
        [self setBtnFrame];
        
        
    }
    return self;
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
