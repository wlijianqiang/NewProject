//
//  TJTestModel.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/24.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJTestModel.h"

@implementation TJTestModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"user_id":@"account_code",
             @"user_token":@"login_token",
             @"user_mobile":@"mobile",
             @"user_name":@"name",
             @"user_portrait":@"portrait",
             @"user_rongcloud_token":@"rongcloud_token"};
}

@end
