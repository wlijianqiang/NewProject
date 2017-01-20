//
//  UIImage+TJQRCode.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TJQRCode)

/**二维码图片生成
 @param content 描述信息
 @param size 生成图片大小
 
 @return 二维码图片
 */

+ (nullable UIImage *)encodeQRImageWithContent:(nullable NSString *)content size:(CGSize)size;

@end
