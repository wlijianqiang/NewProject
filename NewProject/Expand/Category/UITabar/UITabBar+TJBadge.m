//
//  UITabBar+TJBadge.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UITabBar+TJBadge.h"

#define TabBarItemNums 4.0//tabbar的数量
@implementation UITabBar (TJBadge)

#pragma mark - 显示小红点
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 10000 + index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    //确定小红点位置
    float percentX = (index + 0.65)/TabBarItemNums;
    CGFloat x = ceilf(percentX *tabFrame.size.width);
    CGFloat y = ceilf(0.2 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:badgeView];
}

#pragma mark - 移除小红点
- (void)hiddenBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}

-(void)removeBadgeOnItemIndex:(int)index{
    for (UIView *subView in self.subviews) {
        if (subView.tag == 10000 + index) {
            [subView removeFromSuperview];
        }
    }
}

@end
