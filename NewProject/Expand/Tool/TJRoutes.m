//
//  TJRoutes.m
//  NewProject
//
//  Created by 李建强 on 2017/1/21.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJRoutes.h"

@implementation TJRoutes

+ (TJRoutes *)routePattern:(NSString *)routePattern handler:(TJRoutesActionBlock)handlerBlock{
    TJRoutes *route = [[TJRoutes alloc] init];
    route.routePattern = routePattern;
    route.handlerBlock = handlerBlock;
    return route;
}

@end
