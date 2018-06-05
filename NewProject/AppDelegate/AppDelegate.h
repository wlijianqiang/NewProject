//
//  AppDelegate.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/9.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJMainTabBarViewController.h"
#import "TJRoutes.h"
#import <FBMemoryProfiler/FBMemoryProfiler.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong)TJMainTabBarViewController *mainTabBarViewController;
@property (nonatomic, strong)FBMemoryProfiler *memoryProfiler;

@end

