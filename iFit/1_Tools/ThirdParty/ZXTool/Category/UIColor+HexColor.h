//
//  UIImage+HexColor.h
//  iFit
//
//  Created by 区振轩 on 2017/9/23.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGBA)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
