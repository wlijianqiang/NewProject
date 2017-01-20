//
//  TJHTTPSessionManager.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/9.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "AFNetworking.h"

@interface TJHTTPSessionManager : AFHTTPSessionManager

#pragma mark - Public Methods

#pragma mark - GET

- (nullable NSURLSessionDataTask *)GET:(nullable NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

#pragma mark -POST

- (nullable NSURLSessionDataTask *)POST:(nullable NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

#pragma mark - POST Constructing Body

- (nullable NSURLSessionDataTask *)POST:(nullable NSString *)URLString
                             parameters:(nullable id)parameters
              constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
                               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;
@end
