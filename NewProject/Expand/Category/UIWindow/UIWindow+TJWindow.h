//
//  UIWindow+TJWindow.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/17.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (TJWindow)
/**
 获取当前AppDelegate 在显示的UIViewController
 @return UIViewController
 */

- (nullable UIViewController *)currentVisibleViewController;

@end
