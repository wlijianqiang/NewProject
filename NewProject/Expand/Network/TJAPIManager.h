//
//  TJAPIManager.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/9.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <Foundation/Foundation.h>
//Block参数具体根据后台返回来定
typedef void(^SuccessBlock)(NSURLSessionDataTask *_Nullable task, id _Nullable responseObject, NSInteger code,NSString * _Nullable message);
typedef void(^FailureBlock)(NSURLSessionDataTask *_Nullable task, NSError * _Nullable error, NSInteger code,NSString * _Nullable message);
/**
 网络请求管理类
 */
@interface TJAPIManager : NSObject

#pragma mark - Singleton

+ (nullable instancetype)shareManager;

#pragma mark Publice Methods

#pragma mark - 登陆
- (nullable NSURLSessionDataTask *)signinParameters:(nullable id)parameters
                                            success:(nullable SuccessBlock)success
                                            failure:(nullable FailureBlock)failure;
@end
