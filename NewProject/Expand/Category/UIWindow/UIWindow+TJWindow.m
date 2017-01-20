//
//  UIWindow+TJWindow.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/17.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIWindow+TJWindow.h"

@implementation UIWindow (TJWindow)

-(UIViewController *)currentVisibleViewController{
    UIViewController *rootViewController = self.rootViewController;
    return [UIWindow getVisibleViewControllerForm:rootViewController];
}

+ (UIViewController *)getVisibleViewControllerForm:(UIViewController *)rootViewController{
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerForm:[((UINavigationController *)rootViewController) visibleViewController]];
    }else if ([rootViewController isKindOfClass:[UITabBarController class]]){
        return [UIWindow getVisibleViewControllerForm:[((UITabBarController *)rootViewController) selectedViewController]];
    }else{
        if (rootViewController.presentedViewController) {
            return [UIWindow getVisibleViewControllerForm:rootViewController.presentedViewController];
        }else{
            return rootViewController;
        }
    }
}

@end
