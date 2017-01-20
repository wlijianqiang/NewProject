//
//  TJHTTPSessionManager.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/9.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJHTTPSessionManager.h"

@implementation TJHTTPSessionManager

-(instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.requestSerializer = [AFJSONRequestSerializer serializer];//请求格式
    self.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                      @"text/html",
                                                      @"text/json",
                                                      @"text/javascript",
                                                      @"text/plain", nil];
    return self;
}

#pragma mark - Public Methods

#pragma mark - GET
-(NSURLSessionDataTask *)GET:(NSString *)URLString
                  parameters:(id)parameters
                    progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                     success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                     failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    return [super GET:URLString
           parameters:parameters
             progress:downloadProgress
              success:success
              failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    return [super POST:URLString
            parameters:parameters
              progress:uploadProgress
               success:success
               failure:failure];
}

-(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
    constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block
                     progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    return [super POST:URLString
            parameters:parameters
constructingBodyWithBlock:block
              progress:uploadProgress
               success:success
               failure:failure];
}
@end
