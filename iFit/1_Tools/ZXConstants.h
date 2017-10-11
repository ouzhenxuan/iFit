//
//  ZXConstants.h
//  FixCar
//
//  Created by 区振轩 on 2017/6/13.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#ifndef ZXConstants_h
#define ZXConstants_h


#define kCellHeight 48

#define IPhone6Width (ScreenBoundsWidth<ScreenBoundsHeight?375.0:667.0)
#define IPhone6Height (ScreenBoundsWidth<ScreenBoundsHeight?667.0:375.0)
#define IPhone6HeightWithOut64 (ScreenBoundsWidth<ScreenBoundsHeight?603.0:343.0)
#define IPhone6NavbarHeight (ScreenBoundsWidth<ScreenBoundsHeight?64.0:32.0)


#define IPadWidth (ScreenBoundsWidth<ScreenBoundsHeight?768.0:1024.0)
#define IPadHeight (ScreenBoundsWidth<ScreenBoundsHeight?1024.0:768.0)

#define ScreenScale ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?ScreenBoundsWidth/(IPadWidth*1.0) :ScreenBoundsWidth/(IPhone6Width*1.0))

#define ScreenBoundsWidth ScreenBounds.size.width
#define ScreenBoundsHeight ScreenBounds.size.height

#define ScreenBounds [UIScreen mainScreen].bounds

#define ScreenScaleH ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?ScreenBoundsHeight/(IPadHeight*1.0):ScreenBoundsHeight/(IPhone6Height*1.0))

#define ScreenScaleHeightWithOut64 ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?ScreenBoundsHeight/(IPadHeight*1.0):(ScreenBoundsHeight- IPhone6NavbarHeight)/(IPhone6HeightWithOut64*1.0))

#define isIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//#define ScreenBoundsWidth (ScreenBounds.size.width<ScreenBounds.size.height?ScreenBounds.size.width:ScreenBounds.size.height)
//#define ScreenBoundsHeight (ScreenBounds.size.height>ScreenBounds.size.width?ScreenBounds.size.height:ScreenBounds.size.width)

//公共颜色

#define C1      [UIColor colorWithRed:0.882 green:0.192 blue:0.188 alpha:1.000]
#define C1_1    [UIColor colorWithRed:0.780 green:0.216 blue:0.165 alpha:1.000]
#define C2      [UIColor colorWithWhite:0.161 alpha:1.000]
#define C3      [UIColor colorWithWhite:0.384 alpha:1.000]
#define C4      [UIColor colorWithWhite:0.318 alpha:1.000]
#define C5      [UIColor colorWithWhite:0.576 alpha:1.000]
#define C6      [UIColor colorWithWhite:0.706 alpha:1.000]
#define C7      [UIColor colorWithWhite:0.969 alpha:1.000]
#define C8      [UIColor whiteColor]
#define C9      [UIColor colorWithRed:0.071 green:0.627 blue:0.922 alpha:1.000]
#define C10     [UIColor colorWithWhite:0.933 alpha:1.000]

//字体大小
#define ZXFontReznorDownwardSpiral(fontSize) [UIFont fontWithName:@"ReznorDownwardSpiral" size:fontSize * ScreenScale]
#define maxScreenScaleW ScreenScale>1 ? 1 : ScreenScale
#define S1 [UIFont systemFontOfSize: ScreenScale * 36/3.0]
#define S2 [UIFont systemFontOfSize: ScreenScale * 42/3.0]
#define S3 [UIFont systemFontOfSize: ScreenScale * 48/3.0]
#define S4 [UIFont systemFontOfSize: ScreenScale * 54/3.0]
#define ZXIconFontWithSize(fontSize) [UIFont fontWithName:ZXIconFontName size:fontSize]

// 颜色
#define ZXColor_12a0eb [UIColor colorWithRed:0.070 green:0.627 blue:0.921 alpha:1.000]
#define ZXColor_e13e30 [UIColor colorWithRed:0.882 green:0.243 blue:0.188 alpha:1.000]
#define ZXColor_292929 [UIColor colorWithRed:0.160 green:0.160 blue:0.160 alpha:1.000]
#define ZXColor_494949 [UIColor colorWithRed:0.286 green:0.286 blue:0.286 alpha:1.000]
#define ZXColor_626262 [UIColor colorWithRed:0.384 green:0.384 blue:0.384 alpha:1.000]
#define ZXColor_b4b4b4 [UIColor colorWithRed:0.705 green:0.705 blue:0.705 alpha:1.000]
#define ZXColor_f7f7f7 [UIColor colorWithRed:0.968 green:0.968 blue:0.968 alpha:1.000]
#define ZXColor_939393 [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.000]
#define ZXColor_515151 [UIColor colorWithRed:0.317 green:0.317 blue:0.317 alpha:1.000]
#define ZXColor_ffffff [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000]
#define ZXColor_c7372a [UIColor colorWithRed:0.780 green:0.215 blue:0.164 alpha:1.000]
#define ZXColor_eeeeee [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.000]
#define ZXColor_000000 [UIColor colorWithRed:0.249 green:0.000 blue:0.000 alpha:1.000]

// 便捷代码
#define ZXWeak(obj) __weak typeof(obj) weakObj = obj
#define ZXCurrentUser [ZXUser currentUser]


#endif /* ZXConstants_h */
