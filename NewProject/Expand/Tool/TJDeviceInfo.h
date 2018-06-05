//
//  TJDeviceInfo.h
//  NewProject
//
//  Created by lijianqiang on 2018/4/8.
//  Copyright © 2018年 STV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJDeviceInfo : NSObject

//app版本
+ (nullable NSString *)appVersionInfo;

//是否开启系统通知
+ (BOOL)isMessageNotificationServiceOpen;


@end
