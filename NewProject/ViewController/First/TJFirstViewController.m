//
//  TJFirstViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFirstViewController.h"
#import "UITabBar+TJBadge.h"

@interface TJFirstViewController ()

@end

@implementation TJFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    //显示红点
    [self.tabBarController.tabBar showBadgeOnItemIndex:0];
    TJLog(@"test");
}
- (IBAction)hiddenBadgeAction:(UIButton *)sender {
    //隐藏红点
    //[self.tabBarController.tabBar hiddenBadgeOnItemIndex:0];
    [JLRoutes routeURL:[NSURL URLWithString:@"testViewController"] withParameters:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
