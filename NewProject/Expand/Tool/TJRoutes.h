//
//  TJRoutes.h
//  NewProject
//
//  Created by 李建强 on 2017/1/21.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJRoutesDelegate.h"

@interface TJRoutes : NSObject

@property (nonatomic, copy, nullable) NSString *routePattern;
@property (nonatomic, copy, nullable) TJRoutesActionBlock handlerBlock;

+ (nullable TJRoutes *)routePattern:(nullable NSString *)routePattern handler:(nullable TJRoutesActionBlock)handlerBlock;

@end
