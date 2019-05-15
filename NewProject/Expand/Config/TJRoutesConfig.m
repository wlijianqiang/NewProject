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
#import "TJImagePickerViewController.h"
#import "TJOrientationViewController.h"
#import "TJAudioViewController.h"
#import "TJAudioRecorderViewController.h"
#import "TJFoundationCameraViewController.h"
#import "TJWebListTableViewController.h"
#import "TJWebviewProgressLineViewController.h"
#import "TJWKWebViewViewController.h"
#import "TJWKUserScriptViewController.h"
#import "TJWebViewJavascriptBridgeViewController.h"
#import "TJFoundationCameraRecordingViewController.h"
#import "TJMPMoviePlayerController.h"
#import "TJFontSizeAndBlurEffectViewController.h"
#import "TJVideoToolboxViewController.h"
#import "TJVideoToolboxDecodeViewController.h"
#import "JQGestureViewController.h"
#import "JQRunLoopViewController.h"
#import "TJFourTestViewController.h"


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
             [TJRoutes routePattern:@"/TJWebListTableViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJWebListTableViewController *vc = [[TJWebListTableViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJWebviewProgressLineViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJWebviewProgressLineViewController *vc = [[TJWebviewProgressLineViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 
                 return YES;
             }],
            [TJRoutes routePattern:@"/TJWKWebViewViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                TJWKWebViewViewController *vc = [[TJWKWebViewViewController alloc] init];
                [routeDelegate shouldPushViewController:vc animated:YES];
                
                return YES;

            }],
             [TJRoutes routePattern:@"/TJWKUserScriptViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJWKUserScriptViewController *vc = [[TJWKUserScriptViewController alloc] init];
                 vc.imageUrl =  parameters[@"imageUrl"];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 
                 return YES;
                 
             }],
             [TJRoutes routePattern:@"/TJWebViewJavascriptBridgeViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJWebViewJavascriptBridgeViewController *vc = [[TJWebViewJavascriptBridgeViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 
                 return YES;

             }],
             [TJRoutes routePattern:@"/TJMPMoviePlayerController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJMPMoviePlayerController *vc = [[TJMPMoviePlayerController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJFontSizeAndBlurEffectViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 
                 TJFontSizeAndBlurEffectViewController *vc = [[UIStoryboard ThirdTabStoryboard] instantiateViewControllerWithIdentifier:TJFontSizeAndBlurEffectViewController_Storyboard];
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
             }],
             [TJRoutes routePattern:@"/TJImagePickerViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJImagePickerViewController *vc = [[TJImagePickerViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJOrientationViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJOrientationViewController *vc = [[TJOrientationViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJAudioViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJAudioViewController *vc = [[TJAudioViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJAudioRecorderViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 
                 TJAudioRecorderViewController *vc = [[UIStoryboard ThirdTabStoryboard] instantiateViewControllerWithIdentifier:TJStoryboardAudioRecorderViewController_Storyboard];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJFoundationCameraViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 
                 TJFoundationCameraViewController *vc = [[UIStoryboard ThirdTabStoryboard] instantiateViewControllerWithIdentifier:TJStoryboardFoundationCameraViewController_Storyboard];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJFoundationCameraRecordingViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJFoundationCameraRecordingViewController *vc = [[UIStoryboard ThirdTabStoryboard] instantiateViewControllerWithIdentifier:TJFoundationCameraRecordingViewController_Storyboard];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJVideoToolboxViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJVideoToolboxViewController *vc = [[TJVideoToolboxViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/JQGestureViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 JQGestureViewController *vc = [[JQGestureViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/TJVideoToolboxDecodeViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 TJVideoToolboxDecodeViewController *vc = [[TJVideoToolboxDecodeViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             [TJRoutes routePattern:@"/JQRunLoopViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 JQRunLoopViewController *vc = [[JQRunLoopViewController alloc] init];
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }],
             
             [TJRoutes routePattern:@"/TJFourTestViewController" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 JQRunLoopViewController *vc = [[JQRunLoopViewController alloc] init];
                 vc.navigationController.navigationBar.hidden = YES;
                 [routeDelegate shouldPushViewController:vc animated:YES];
                 return YES;
             }]
            ];
}

@end
