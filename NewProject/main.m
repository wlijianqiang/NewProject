//
//  main.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/9.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#if DEBUG
    #import <FBAllocationTracker/FBAllocationTracker.h>
    #import <FBAssociationManager.h>
#endif

int main(int argc, char * argv[]) {
    @autoreleasepool {

#if DEBUG//添加fb内存管理插件
        [FBAssociationManager hook];
        [[FBAllocationTrackerManager sharedManager] startTrackingAllocations];
        [[FBAllocationTrackerManager sharedManager] enableGenerations];
#endif
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
