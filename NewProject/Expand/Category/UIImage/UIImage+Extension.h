//
//  UIImage+Extension.h
//  NewProject
//
//  Created by lijianqiang on 2017/2/21.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  生成一张二维码图片
 *
 *  @param content 描述信息
 *  @param size 生成图片大小
 *
 *  @return 二维码图片
 */
+ (UIImage *)encodeQRImageWithContent:(NSString *)content size:(CGSize)size;

/**
 *  使用vImage API进行图像的模糊处理
 *
 *  @param image 原图
 *  @param blur  模糊度（0.0~1.0）
 *
 *  @return 糊处理之后的图像
 */
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/**
 *  根据颜色生成一张图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  生成圆角的图片
 *
 *  @param originImage 原始图片
 *  @param borderColor 边框原色
 *  @param borderWidth 边框宽度
 *
 *  @return 圆形图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
