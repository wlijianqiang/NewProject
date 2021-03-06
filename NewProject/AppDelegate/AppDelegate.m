//
//  AppDelegate.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/9.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkActivityLogger.h"
#import "AppDelegate+JLRoute.h"
#import "TJCacheCleanerPlugin.h"
#import "TJRetainCycleLoggerPlugin.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#if DEBUG//打印日志
    [[AFNetworkActivityLogger sharedLogger] startLogging];
#endif
    [TJProjectConfig setSystemConfig];
    [self setupRoute];
    [self memoryManage];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    TJLog(@"模拟器路径为：%@",path);
    //全屏禁止触摸开启
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    //全屏禁止触摸关闭
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    return YES;
}

- (void)memoryManage {
#if DEBUG
    self.memoryProfiler = [[FBMemoryProfiler alloc] initWithPlugins:@[[TJCacheCleanerPlugin new],
                          [TJRetainCycleLoggerPlugin new]]
                          retainCycleDetectorConfiguration:nil];
    [self.memoryProfiler enable];

#endif
}
//设置屏幕旋转方向 或直接在plis文件中设置
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskAll;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
