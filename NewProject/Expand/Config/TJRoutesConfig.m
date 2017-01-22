//
//  TJRoutesConfig.m
//  NewProject
//
//  Created by 李建强 on 2017/1/21.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJRoutesConfig.h"
#import "TJRoutes.h"

@implementation TJRoutesConfig


+ (NSArray *)registerRoutes{
    return @[
             [TJRoutes routePattern:@"" handler:^BOOL(id<TJRoutesDelegate>  _Nullable routeDelegate, NSString * _Nullable routePattern, NSDictionary * _Nullable parameters) {
                 
                 return YES;
             }]
             
             ];
}

@end
