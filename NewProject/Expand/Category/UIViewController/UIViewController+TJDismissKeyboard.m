//
//  UIViewController+TJDismissKeyboard.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIViewController+TJDismissKeyboard.h"

@implementation UIViewController (TJDismissKeyboard)

-(void)setupForDismissKeyboard{
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAnywhereToDismissKeyboard:)];
    singleTapGestureRecognizer.delegate = self;
    
    __weak typeof(self)weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.view addGestureRecognizer:singleTapGestureRecognizer];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.view removeGestureRecognizer:singleTapGestureRecognizer];
    }];
}

- (void)touchAnywhereToDismissKeyboard:(UIGestureRecognizer *)sender{
    [self.view endEditing:YES];
}

#pragma mark - 判断手势是否可用
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]] || [touch.view isKindOfClass:[UITableView class]]) {
        return NO;
    }
    return YES;
}

@end
