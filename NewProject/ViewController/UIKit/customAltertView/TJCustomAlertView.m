//
//  TJCustomAlertView.m
//  NewProject
//
//  Created by lijianqiang on 2017/3/2.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJCustomAlertView.h"

typedef NS_ENUM(NSInteger, ButtonTag){
    ButtonTag_Canale = 8001,
    ButtonTag_Ok = 8002,
};
@interface TJCustomAlertView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *CancleButton;
@property (weak, nonatomic) IBOutlet UIButton *OkButton;


@end

@implementation TJCustomAlertView


- (void)customAlterViewForTitle:(NSString *)title message:(NSString *)message{
    self.titleLabel.text = title;
    self.messageLabel.text = message;
}

- (void)dismiss{
    [UIView animateWithDuration:.3 animations:^{
        [self removeFromSuperview];
    }];
}

- (IBAction)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case ButtonTag_Canale:
        {
        if ([self.delegate respondsToSelector:@selector(customAlertView:cancleButton:)]) {
                [self.delegate customAlertView:self cancleButton:sender];
            }
        }
            break;
        case ButtonTag_Ok:
        {
            if ([self.delegate respondsToSelector:@selector(customAlertView:okButton:)]) {
                [self.delegate customAlertView:self okButton:sender];
            }
            
        }
            break;
    }

}

@end
