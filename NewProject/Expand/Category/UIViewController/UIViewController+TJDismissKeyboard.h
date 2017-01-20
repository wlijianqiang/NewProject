//
//  UIViewController+TJDismissKeyboard.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TJDismissKeyboard)<UIGestureRecognizerDelegate>
/**
 收键盘 离开页面时记得销毁通知
 */
- (void)setupForDismissKeyboard;

@end
