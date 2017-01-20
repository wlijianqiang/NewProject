//
//  UIImage+TJGaussFuzzy.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TJGaussFuzzy)
/**
 高斯模糊
 */
+ (nullable UIImage *)blurryImage:(nullable UIImage *)image withBlurLevel:(CGFloat)blur;
@end
