//
//  TJProjectConfig.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/11.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJProjectConfig.h"
#import "IQKeyboardManager.h"
#import "Aspects.h"

@implementation TJProjectConfig

+(void)setSystemConfig{
    [[self class] setUIAppearance];
}

+ (void)setUIAppearance{
    //键盘管理
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [IQKeyboardManager sharedManager].enable = YES;
    
    [[UIView appearance] setContentMode:UIViewContentModeScaleAspectFill];
    
    [[UIScrollView appearance] setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [[UITableView appearance] setSeparatorInset:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
    [[UITableView appearance] setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setTintColor:[UIColor redColor]];
    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setBarTintColor:[UIColor redColor]];
    
    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setTranslucent:YES];
    
    //导航栏字体
    NSDictionary *attributeDictionary = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                   NSShadowAttributeName:[NSShadow new],
                                          NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributeDictionary];
    
    
    
}
@end
