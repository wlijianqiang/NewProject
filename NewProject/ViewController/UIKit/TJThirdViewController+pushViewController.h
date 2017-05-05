//
//  TJThirdViewController+pushViewController.h
//  NewProject
//
//  Created by lijianqiang on 2017/5/4.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJThirdViewController.h"
#import "TJCustomAlertView.h"

@interface TJThirdViewController (pushViewController)<TJCustomAlertViewDelegate>

- (void)showAltertViewForRow:(NSInteger )row;

- (void)showCollectionViewForRow:(NSInteger )row;
@end
