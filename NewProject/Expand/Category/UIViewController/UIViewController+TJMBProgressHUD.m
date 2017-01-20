//
//  UIViewController+TJMBProgressHUD.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIViewController+TJMBProgressHUD.h"
#import <objc/runtime.h>
/**
 key值必须保证是有个对象级别的为一常量，一般有三种推荐的key值
 1.声明 static char kAssociatedObjectKey; ，使用 &kAssociatedObjectKey 作为 key 值;
 2.声明 static void *kAssociatedObjectKey = &kAssociatedObjectKey; ，使用 kAssociatedObjectKey 作为 key 值；
 3.用 selector ，使用 getter 方法的名称作为 key 值。
 */
static const void *kAssociatedObjectKey = &kAssociatedObjectKey;

@implementation UIViewController (TJMBProgressHUD)

- (void)setHUD:(MBProgressHUD *)HUD{

    objc_setAssociatedObject(self, @selector(HUD), HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, _cmd);//OC 中_cmd代表本方法的名称
}

-(void)showHUDAddedTo:(UIView *)view{
    [self showHUDAddedTo:view hint:nil];
}

- (void)showHUDAddedTo:(UIView *)view hint:(NSString *)hint{
    if (view == nil) view = [[UIApplication sharedApplication].delegate window];
    if (hint == nil) hint = @"";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = hint;
    hud.graceTime = 0.5f;
    [self setHUD:hud];
}

- (void)showHint:(NSString *)hint {
    if (!hint || (hint.length == 0)) return;
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    [hud hideAnimated:YES afterDelay:1.0f];
}

-(void)hideHub{
    [[self HUD] hideAnimated:YES];

}

@end
