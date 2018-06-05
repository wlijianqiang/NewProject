//
//  TJRetainCycleLoggerPlugin.m
//  NewProject
//
//  Created by lijianqiang on 2018/5/15.
//  Copyright © 2018年 STV. All rights reserved.
//

#import "TJRetainCycleLoggerPlugin.h"

@implementation TJRetainCycleLoggerPlugin

/**
 通过 RetainCycleLoggerPlugin文件 如果存在循环引用，就会输出类似的内容：
 通过这个线索，你就可以找到你代码中可能导致循环引用的地方了

 @param retainCycles {(
 (
 "-> MyObject ",
 "-> _someObject -> __NSArrayI "
 )
 )}
 */
-(void)memoryProfilerDidFindRetainCycles:(NSSet *)retainCycles {
    if (retainCycles.count > 0) {
        TJLog(@"\n retainCyles = \n%@",retainCycles);
    }
}

@end
