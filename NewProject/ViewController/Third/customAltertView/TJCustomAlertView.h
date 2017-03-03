//
//  TJCustomAlertView.h
//  NewProject
//
//  Created by lijianqiang on 2017/3/2.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TJCustomAlertView;
@protocol TJCustomAlertViewDelegate <NSObject>

- (void)customAlertView:(TJCustomAlertView *)customAlertView cancleButton:(UIButton *)sender;

- (void)customAlertView:(TJCustomAlertView *)customAlertView okButton:(UIButton *)sender;

@end

@interface TJCustomAlertView : UIView

@property (nonatomic, weak)id <TJCustomAlertViewDelegate>delegate;

- (void)customAlterViewForTitle:(NSString *)title message:(NSString *)message;

- (void)dismiss;

@end
