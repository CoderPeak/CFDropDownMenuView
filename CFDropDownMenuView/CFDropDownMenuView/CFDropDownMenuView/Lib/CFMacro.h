//
//  CFMacro.h
//  CFDropDownMenuView
//
//  Created by Peak on 16/5/28.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#ifndef CFMacro_h
#define CFMacro_h

/**
 *  资源图片路径相关 宏
 */
#define CFDrowMenuViewSrcName(file) [@"CFDropDownMenuView.bundle" stringByAppendingPathComponent:file]
#define CFDrowMenuViewFrameworkSrcName(file) [@"Frameworks/CFDropDownMenuView.framework/CFDropDownMenuView.bundle" stringByAppendingPathComponent:file]

/**
 *  颜色相关 宏
 */
#define UIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define  CF_Color_TextLightGrayColor UIColorFromHex(0x999999)
#define  CF_Color_TextGrayColor UIColorFromHex(0x666666)
#define  CF_Color_TextDarkGrayColor UIColorFromHex(0x333333)
#define  CF_Color_SepertLineColor UIColorFromHex(0xdddddd)
#define  CF_Color_DefaultColor  UIColorFromHex(0x1e8cd4)  // 默认的颜色-蓝
#define  CF_Color_DefalutBackGroundColor UIColorFromHex(0xf2f2f2)

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
// 随机色
#define CFRandomColor RGBA(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1.0)

/**
 *  字体相关 宏
 */
#define CF_Font_15 [UIFont systemFontOfSize:15]

/**
 *  尺寸相关 宏
 */
#define CFScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define CFScreenHeight  ([UIScreen mainScreen].bounds.size.height)

#endif /* CFMacro_h */