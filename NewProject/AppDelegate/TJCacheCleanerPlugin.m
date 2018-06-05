//
//  TJCacheCleanerPlugin.m
//  NewProject
//
//  Created by lijianqiang on 2018/5/15.
//  Copyright © 2018年 STV. All rights reserved.
//

#import "TJCacheCleanerPlugin.h"

@implementation TJCacheCleanerPlugin

-(void)memoryProfilerDidMarkNewGeneration {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
