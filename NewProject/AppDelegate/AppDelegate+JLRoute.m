//
//  AppDelegate+JLRoute.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/22.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "AppDelegate+JLRoute.h"

@implementation AppDelegate (JLRoute)

/**
 添加路由
 */
- (void)setupRoute{
    self.mainTabBarViewController = [[UIStoryboard MainStoryboard]instantiateViewControllerWithIdentifier:TJMainTabBarViewController_Storyboard];
    [[TJRoutesConfig registerRoutes] enumerateObjectsUsingBlock:^(TJRoutes *route, NSUInteger idx, BOOL * _Nonnull stop) {
        [[JLRoutes globalRoutes] addRoute:route.routePattern handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
            route.handlerBlock(self.mainTabBarViewController,route.routePattern,parameters);
            return YES;
        }];
    }];
}

- (void)chooseRootViewController:(UIViewController *)rootViewController{
    if (self.window.rootViewController == nil) {
        self.window.rootViewController = rootViewController;
        return;
    }
    [UIView transitionFromView:self.window.rootViewController.view toView:rootViewController.view duration:0.25f options:UIViewAnimationOptionCurveEaseInOut |UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        self.window.rootViewController = rootViewController;
    }];
}


@end
