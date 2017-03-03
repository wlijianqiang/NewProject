//
//  UIView+Nib.m
//  NewProject
//
//  Created by lijianqiang on 2017/3/2.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)


+ (instancetype)loadFromNib
{
    return [[[UINib nibWithNibName:NSStringFromClass(self) bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
}

@end
