//
//  LabelNumView.h
//  iFit
//
//  Created by 区振轩 on 2017/9/23.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelNumView : UIView

@property (nonatomic,assign) int Num;
@property (nonatomic,copy) NSString * Title;
@property (nonatomic,assign) int NumFontSize;
-(instancetype) initViewWithNum:(int)num Title:(NSString *)title;

@end
