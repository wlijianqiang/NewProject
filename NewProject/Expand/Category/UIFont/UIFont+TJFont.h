//
//  UIFont+TJFont.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (TJFont)
/**
 12号字体
 @return 12号字体
 */
+( nullable UIFont *)defaultFontOfSize12;

/**
 13号字体
 @return 13号字体
 */
+( nullable UIFont *)defaultFontOfSize13;

/**
 14号字体
 @return 14号字体
 */
+( nullable UIFont *)defaultFontOfSize14;

/**
 15号字体
 @return 15号字体
 */
+( nullable UIFont *)defaultFontOfSize15;

/**
 16号字体
 @return 16号字体
 */
+( nullable UIFont *)defaultFontOfSize16;

/**
 18号字体
 @return 18号字体
 */
+( nullable UIFont *)defaultFontOfSize18;

/**
 20号字体
 @return 20号字体
 */
+( nullable UIFont *)defaultFontOfSize20;

/**
 获取指定的字体大小
 
 @param size 字体大小
 
 @return 指定的字体大小
 */
+ (nullable UIFont *)defaultFontOfSize:(NSUInteger)size;
/**
 预留文字方法，方便以后更换字体
 @param size 字体的大小
 @param name 字体名称
 
 @return 字体
 */
+ (nullable UIFont *)fontOfSize:(NSInteger)size fontName:(nullable NSString *)name;

/**
 预留的加粗文字方法，方便以后更换字体
 
 @param size 加粗字体的大小
 @param name 字体名称
 
 @return 加粗字体
 */
+ (nullable UIFont *)boldFontOfSize:(NSUInteger)size fontName:(nullable NSString *)name;

@end
