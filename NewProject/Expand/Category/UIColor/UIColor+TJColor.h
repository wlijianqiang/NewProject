//
//  UIColor+TJColor.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TJColor)
/**通过 Hex 设置的颜色 UIColor*/
+ (UIColor *)colorWithHexString:(NSString *)hexString;
/**通过 RGB 设置的颜色 UIColor */
+ (UIColor *)RGBColorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha;
/** 随即颜色*/
+ (UIColor *)randomColor;
/**默认颜色*/
+ (UIColor *)defaultColor;

@end
