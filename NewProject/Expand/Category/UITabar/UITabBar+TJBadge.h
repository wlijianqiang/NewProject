//
//  UITabBar+TJBadge.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (TJBadge)

#pragma mark - 显示小红点
- (void)showBadgeOnItemIndex:(int)index;

#pragma mark - 隐藏小红点
-(void)hiddenBadgeOnItemIndex:(int)index;

@end
