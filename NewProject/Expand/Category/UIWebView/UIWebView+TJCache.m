//
//  UIWebView+TJCache.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIWebView+TJCache.h"

@implementation UIWebView (TJCache)

+(void)clearCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

+ (void)clearCache{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
