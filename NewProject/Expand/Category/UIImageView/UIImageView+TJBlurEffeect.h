//
//  UIImageView+TJBlurEffeect.h
//  NewProject
//
//  Created by lijianqiang on 2017/5/12.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TJBlurEffeect)

/**
 *  使用系统控件实现高斯模糊
 *
 *  @param rect 尺寸
 *  @param alpha 透明度
 *
 *  @return UIImageView
 */
+ (UIImageView *)imageVIew:(UIImageView *)imageView visualEffectViewFrame:(CGRect )rect alpha:(CGFloat)alpha;


@end
