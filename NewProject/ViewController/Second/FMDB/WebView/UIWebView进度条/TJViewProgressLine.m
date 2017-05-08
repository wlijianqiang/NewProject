//
//  TJViewProgressLine.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/8.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJViewProgressLine.h"

@implementation TJViewProgressLine

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor defaultColor];

    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
}
- (void)startLoadingAnimation{
    self.hidden = NO;
    self.mj_w = 0.0f;
    kWeakSelf
    [UIView animateWithDuration:0.4 animations:^{
        
        weakSelf.mj_w = kMainScreenWidth *0.3;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.mj_w = kMainScreenWidth * 0.6;
        }];

    }];
}

-(void)endLoadingAnimation{
    kWeakSelf
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.mj_w = kMainScreenWidth;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}
@end
