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
    self.requestSerializer = [AFJSONRequestSerializer serializer];//请求的数据格式/默认是二进制的
    self.responseSerializer = [AFJSONResponseSerializer serializer];//响应的数据格式/默认是JSON格式
    self.requestSerializer.timeoutInterval = 10.0f;//超时时间
    //可接受的数据类型
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

#pragma mark - POST （发送数据有两种形式）发送纯文本内容

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
#pragma mark - POST Constructing Body 发送的 body 部分带有文件（图片，音频或者其他二进制数据）

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
