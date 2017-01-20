//
//  TJRoutesDelegate.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/17.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TJRoutesDelegate <NSObject>

@required

- (void)shouldPushViewController:(nullable UIViewController *)viewController animated:(BOOL)animated;
- (void)shouldPresentViewController:(nullable UIViewController *)viewController animated:(BOOL)animated;
#pragma mark - 向视图控制器容器中添加子视图控制器
- (void)shouldAddChildViewController:(nullable UIViewController *)childViewController;
- (void)shouldKeyWindowViewController:(nullable UIViewController *)viewController;
- (void)dismissKeyWindowViewController:(nullable UIViewController *)viewController;

@end

typedef BOOL(^TJRoutesActionBlock)(id<TJRoutesDelegate> _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters);
