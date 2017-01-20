//
//  UIViewController+TJMBProgressHUD.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

//NS_ASSUME_NONNULL_BEGIN//引用类型的参数指定一个是否为空的标注，可用宏定义之间所有的代码的默认标记都是 nonnull

@interface UIViewController (TJMBProgressHUD)

@property (nonatomic, strong, nullable) MBProgressHUD *HUD;

- (void)showHUDAddedTo:(nullable UIView *)view;
- (void)showHUDAddedTo:(nullable UIView *)view hint:(nullable NSString *)hint;
- (void)showHint:(nullable NSString *)hint;
- (void)hideHub;
@end

//NS_ASSUME_NONNULL_END
