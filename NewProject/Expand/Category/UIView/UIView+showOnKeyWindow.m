//
//  UIView+showOnKeyWindow.m
//  NewProject
//
//  Created by lijianqiang on 2017/2/3.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIView+showOnKeyWindow.h"

@implementation UIView (showOnKeyWindow)

- (BOOL)isShowingOnKeyWindow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //将view在父视图的frame转换成window的frame
    CGRect converFrame = [self.superview convertRect:self.frame toView:keyWindow];
    CGRect windowBounds = keyWindow.bounds;
    //判断控件是否在主窗口上(是否有交叉)
    BOOL isOnWindow = CGRectIntersectsRect(converFrame, windowBounds);
    //再判断这个控件是否真正显示在窗口范围内(是否在窗口上，是否隐藏，透明)
    BOOL isShowOnWindow = (self.window == keyWindow) && !self.isHidden && (self.alpha > 0.01) && isOnWindow;
    return isShowOnWindow;
}

@end
