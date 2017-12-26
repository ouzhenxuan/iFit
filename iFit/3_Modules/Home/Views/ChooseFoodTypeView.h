//
//  ChooseFoodTypeController.h
//  iFit
//
//  Created by 区振轩 on 2017/11/27.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseFoodTypeViewDelegate

-(void)clickBtnAction:(int)index;

@end


@interface ChooseFoodTypeView : UIView
@property (nonatomic,weak) id Delegate;

- (void)showAnimation;


@end
