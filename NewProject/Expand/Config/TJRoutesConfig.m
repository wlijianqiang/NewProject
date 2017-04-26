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
#import "TJFMDBViewController.h"
#import "TJCollectionViewController.h"
#import "TJStoryboardCollectionViewController.h"
@implementation TJRoutesConfig


+ (NSArray *)registerRoutes{
    return @[
             //测试页面
             [TJRoutes routePattern:@"/testViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJTestViewController *vc = [[UIStoryboard FirstTabStoryboard] instantiateViewControllerWithIdentifier:TJTestViewController_Storyboard];
                     [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             //tableView描边
             [TJRoutes routePattern:@"/TJStrockViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 
                 TJStrockViewController *vc = [[TJStrockViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             
             //FMDB
             [TJRoutes routePattern:@"/TJFMDBViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJFMDBViewController *vc = [[UIStoryboard SecondTabStoryboard] instantiateViewControllerWithIdentifier:TJFMDBViewController_Storyboard];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 
                 return YES;
             }],
             //CollectionViewController 
             [TJRoutes routePattern:@"/TJCollectionViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJCollectionViewController *vc = [[TJCollectionViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJStoryboardCollectionViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 
                 TJStoryboardCollectionViewController *vc = [[UIStoryboard ThirdTabStoryboard] instantiateViewControllerWithIdentifier:TJStoryboardCollectionViewController_Storyboard];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }]
            
            ];
}

@end
