//
//  TJRoutesConfig.m
//  NewProject
//
//  Created by 李建强 on 2017/1/21.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJRoutesConfig.h"
#import "TJRoutes.h"

#import "TJTestViewController.h"
#import "TJStrockViewController.h"

@implementation TJRoutesConfig


+ (NSArray *)registerRoutes{
    return @[
             //测试页面
             [TJRoutes routePattern:@"testViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJTestViewController *vc = [[UIStoryboard FirstTabStoryboard] instantiateViewControllerWithIdentifier:TJTestViewController_Storyboard];
                     [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             //tableView描边
             [TJRoutes routePattern:@"TJStrockViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 
                 TJStrockViewController *stv = [[TJStrockViewController alloc] init];
                 [routeDelegate shouldPushViewController:stv animated:YES];
                 return YES;
             }]
           
             ];
}

@end
