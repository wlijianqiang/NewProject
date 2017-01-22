//
//  UIStoryboard+NewProject.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIStoryboard+NewProject.h"

@implementation UIStoryboard (NewProject)

+ (UIStoryboard *)MainStoryboard{
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

+ (UIStoryboard *)FirstTabStoryboard{
  return [UIStoryboard storyboardWithName:@"First" bundle:nil];
}

+ (UIStoryboard *)SecondTabStoryboard{
    return [UIStoryboard storyboardWithName:@"Second" bundle:nil];
}

+ (UIStoryboard *)ThirdTabStoryboard{
    return [UIStoryboard storyboardWithName:@"Third" bundle:nil];
}

+ (UIStoryboard *)FourTabStoryboard{
    return [UIStoryboard storyboardWithName:@"Four" bundle:nil];
}

@end
