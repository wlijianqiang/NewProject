//
//  TJThirdViewController+pushViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/4.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJThirdViewController+pushViewController.h"


@implementation TJThirdViewController (pushViewController)

- (void)showAltertViewForRow:(NSInteger )row{
    switch (row) {
        case 0:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            
            [alertController addAction:cancelAction];
            
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 1:
        {
            TJCustomAlertView *customAlertView = [TJCustomAlertView loadFromNib];
            customAlertView.frame = self.view.frame;
            customAlertView.delegate = self;
            [customAlertView customAlterViewForTitle:@"标题" message:@"不知所云"];
            [[UIApplication sharedApplication].keyWindow addSubview:customAlertView];
        }
            break;
    }
}

- (void)showCollectionViewForRow:(NSInteger )row{
    
    switch (row) {
        case 0:
        {
            [JLRoutes routeURL:[NSURL URLWithString:@"/TJCollectionViewController"] withParameters:nil];
        }
            break;
        case 1:
        {
            [JLRoutes routeURL:[NSURL URLWithString:@"/TJStoryboardCollectionViewController"] withParameters:nil];
        }
            break;
        case 2:
        {
            [JLRoutes routeURL:[NSURL URLWithString:@"/TJImagePickerViewController"] withParameters:nil];
        }
            break;
            
    }
}
#pragma mark - TJCustomAlertViewDelegate
- (void)customAlertView:(TJCustomAlertView *)customAlertView cancleButton:(UIButton *)sender{
    [customAlertView dismiss];
}

- (void)customAlertView:(TJCustomAlertView *)customAlertView okButton:(UIButton *)sender{
    [customAlertView dismiss];
}


@end
