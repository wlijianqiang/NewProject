//
//  TJAPIManager.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/9.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJAPIManager.h"
#import "TJHTTPSessionManager.h"
#import "TJAPIConst.h"

@interface TJAPIManager ()

@property (nonatomic, strong ,nullable) TJHTTPSessionManager *HTTPSessionManager;

@end
@implementation TJAPIManager

#pragma mark Singleton

+(instancetype)shareManager{
    static TJAPIManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc]initWithBaseURL:[NSURL URLWithString:kApiBaseURL]];
    });
    return shareManager;
}

- (instancetype)initWithBaseURL:(nullable NSURL *)URL{
    self = [super init];
    if (!self) {
        return nil;
    }
    if (URL) {
        self.HTTPSessionManager = [[TJHTTPSessionManager alloc]initWithBaseURL:URL];
    }
    return self;
}

#pragma mark -GET

- (nullable NSURLSessionDataTask *)GET:(nullable NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(SuccessBlock)success
                               failure:(FailureBlock)failure {
    return [self GET:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (nullable NSURLSessionDataTask *)GET:(nullable NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress
                               success:(SuccessBlock)success
                               failure:(FailureBlock)failure{
    
    self.HTTPSessionManager = [[TJHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kApiBaseURL]];
    return [self.HTTPSessionManager GET:URLString
                             parameters:parameters
                               progress:downloadProgress
                                success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSInteger code = [[NSString stringWithFormat:@"%@", responseObject[@"code"]] integerValue];
                    NSString *message = [NSString stringWithFormat:@"%@", responseObject[@"msg"]];
                     NSLog(@"%@%@, code: %zi, message: %@, responseObject: %@", kApiBaseURL, URLString, code, message, responseObject);
                    if (success) {
                        success(task, responseObject, code, message);
                    }else{
                        
                    }
                }else{
                    NSLog(@"%@%@, responseObject: %@", kApiBaseURL, URLString, responseObject);
                    if (failure) {
                        failure(task, nil, 99999, @"ErrorMessage");
                    }
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task , NSError * _Nullable error) {
                if (error) {
                    NSLog(@"%@%@, code: %zi, message: %@, error: %@", kApiBaseURL, URLString, error.code, error.description, error);
                    if (failure) {
                        failure(task, error, error.code, @"ErrorMessage");
                    }
                } else {
                    if (failure) {
                        failure(task, nil, 99999, @"ErrorMessage");
                    }
                }
        }];
}

#pragma mark - POST

- (nullable NSURLSessionDataTask *)POST:(nullable NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(SuccessBlock)success
                               failure:(FailureBlock)failure {
    return [self POST:URLString parameters:parameters success:success failure:failure];
}

- (nullable NSURLSessionDataTask *)POST:(nullable NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure{
    self.HTTPSessionManager = [[TJHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kApiBaseURL]];
    return [self.HTTPSessionManager POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger code = [[NSString stringWithFormat:@"%@", responseObject[@"code"]] integerValue];
            NSString *message = [NSString stringWithFormat:@"%@", responseObject[@"msg"]];
            NSLog(@"%@%@, code: %zi, message: %@, responseObject: %@", kApiBaseURL, URLString, code, message, responseObject);
            if (success) {
                success(task, responseObject, code, message);
            }else{
                
            }
        }else{
            NSLog(@"%@%@, responseObject: %@", kApiBaseURL, URLString, responseObject);
            if (failure) {
                failure(task, nil, 99999, @"ErrorMessage");
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task , NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@%@, code: %zi, message: %@, error: %@", kApiBaseURL, URLString, error.code, error.description, error);
            if (failure) {
                failure(task, error, error.code, @"ErrorMessage");
            }
        } else {
            if (failure) {
                failure(task, nil, 99999, @"ErrorMessage");
            }
        }
    }];
}

#pragma mark - 登陆
-(NSURLSessionDataTask *)signinParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    return [self POST:kSiginURL parameters:parameters success:success failure:failure];
}
@end
