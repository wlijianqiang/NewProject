//
//  TJTestModel.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/24.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJModel.h"
/**
 用户信息模型
 */
@interface TJTestModel : TJModel

@property (nonatomic, copy, nullable) NSString *user_id;
@property (nonatomic, copy, nullable) NSString *user_token;
@property (nonatomic, copy, nullable) NSString *user_mobile;
@property (nonatomic, copy, nullable) NSString *user_name;
@property (nonatomic, copy, nullable) NSString *user_portrait;
@property (nonatomic, copy, nullable) NSString *user_rongcloud_token;

@end
