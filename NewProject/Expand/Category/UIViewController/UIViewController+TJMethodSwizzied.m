//
//  UIViewController+TJMethodSwizzied.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIViewController+TJMethodSwizzied.h"
#import <objc/runtime.h>

#import "TJThirdViewController.h"

@implementation UIViewController (TJMethodSwizzied)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获取原有方法  class_getInstanceMethod 得到类的实例方法  class_getClassMethod 得到类的方法
        Method originalWillAppear = class_getInstanceMethod([self class], @selector(viewWillAppear:));
        //获取修改后的方法
        Method swizzledWillAppear = class_getInstanceMethod([self class], @selector(swizzled_viewWillAppear:));
        BOOL didAddWillAppear = class_addMethod([self class], @selector(viewWillAppear:), method_getImplementation(swizzledWillAppear), method_getTypeEncoding(swizzledWillAppear));
        if (didAddWillAppear) {
            //对函数动态替换
            class_replaceMethod([self class], @selector(swizzled_viewWillAppear:), method_getImplementation(originalWillAppear), method_getTypeEncoding(originalWillAppear));
        }else{
            //交换方法
            method_exchangeImplementations(originalWillAppear, swizzledWillAppear);
        }
        
        Method originalDealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
        Method swizzledDealloc = class_getInstanceMethod([self class], @selector(swizzled_dealloc));
        BOOL didAddWDealloc = class_addMethod([self class], NSSelectorFromString(@"dealloc"), method_getImplementation(swizzledDealloc), method_getTypeEncoding(swizzledDealloc));
        if (didAddWDealloc) {
            class_replaceMethod([self class], @selector(swizzled_dealloc), method_getImplementation(originalDealloc), method_getTypeEncoding(originalDealloc));
        }else{
            method_exchangeImplementations(originalDealloc, swizzledDealloc);
        }
    });
}

- (void)swizzled_viewWillAppear:(BOOL)animated{
    NSString *classPrefix = NSStringFromClass([self class]);
    if ([[classPrefix substringWithRange:NSMakeRange(0, 2)]isEqualToString:@"TJ"]) {//判断类的前缀
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        self.navigationController.delegate = self;
    }
}

- (void)swizzled_dealloc{
    NSString *classPrefix = NSStringFromClass([self class]);
    if ([[classPrefix substringWithRange:NSMakeRange(0, 2)]isEqualToString:@"TJ"]) {//判断类的前缀
         NSLog(@"swizzled_dealloc: <%@ 销毁了>", NSStringFromClass([self class]));
    }
    [self swizzled_dealloc];
}

// 可以在这里添加一些全局的delegate
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:[self needNavigationBarHiddenInViewController:viewController] animated:animated];
}

//某些页面隐藏导航栏
- (BOOL)needNavigationBarHiddenInViewController:(UIViewController *)viewController {
    BOOL needNavigationBarHidden = NO;
        if ([viewController isKindOfClass:[TJThirdViewController class]]) {
            needNavigationBarHidden = YES;
        }
    return needNavigationBarHidden;
}

@end
