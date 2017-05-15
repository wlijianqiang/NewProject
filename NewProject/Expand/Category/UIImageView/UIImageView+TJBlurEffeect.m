//
//  UIImageView+TJBlurEffeect.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/12.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIImageView+TJBlurEffeect.h"

@implementation UIImageView (TJBlurEffeect)

+ (UIImageView *)imageVIew:(UIImageView *)imageView visualEffectViewFrame:(CGRect )rect alpha:(CGFloat)alpha{
   
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    effectView.alpha = alpha;
    [imageView addSubview:effectView];
    
    return imageView;
}

@end
