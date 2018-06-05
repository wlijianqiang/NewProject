//
//  TJDeviceInfo.m
//  NewProject
//
//  Created by lijianqiang on 2018/4/8.
//  Copyright © 2018年 STV. All rights reserved.
//

#import "TJDeviceInfo.h"

@implementation TJDeviceInfo

+ (NSString *)appVersionInfo{
    return [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (BOOL)isMessageNotificationServiceOpen {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];

    if (UIUserNotificationTypeNone != setting.types) {
        return YES;
    }else{
        return NO;
    }
}

@end
