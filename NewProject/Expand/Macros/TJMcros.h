//
//  TJMcros.h
//  NewProject
//
//  Created by lijianqiang on 2017/2/6.
//  Copyright © 2017年 STV. All rights reserved.
//

#ifndef TJMcros_h
#define TJMcros_h



#if DEBUG//打印日志
#define TJLog(...) NSLog(__VA_ARGS__)
#else
#define TJLog(...) 
#endif

//版本判断
#ifndef iOS8Later
#define iOS8Later ([UIDevice currentDevice].systemName.floatValue >= 8.0f)
#endif

//获取屏幕宽度
#ifndef kMainScreenWidth
#define kMainScreenWidth ([UIScreen mainScreen].bounds.size.width)
#endif

//获取屏幕高度
#ifndef kMainScreenHeight
#define kMainScreenHeight ([UIScreen mainScreen].bounds.size.height)
#endif

// iPhone 4s
#ifndef iPhone4s
#define iPhone4s (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480.0f) < DBL_EPSILON)
#endif

// iPhone 5 & iPhone 5c & iPhone 5s & iPhone SE
#ifndef iPhone5
#define iPhone5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568.0f) < DBL_EPSILON)
#endif

// iPhone 6 & iPhone 6s & iPhone 7
#ifndef iPhone6
#define iPhone6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667.0f) < DBL_EPSILON)
#endif

// iPhone 6Plus & iPhone 6sPlus & iPhone 7Plus
#ifndef iPhone6Plus
#define iPhone6Plus (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736.0f) < DBL_EPSILON)
#endif

//weakify
//#ifndef kWeakSelf
//#define kWeakSelf @weakify(self)
//#endif

#ifndef kWeakSelf
#define kWeakSelf __weak typeof(self) weakSelf = self;
#endif

//strongify
//#ifndef kStrongSelf
//#define kStrongSelf @strongify(self) Reactive Cocoa
//#endif

#ifndef kStrongSelf
#define kStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;
#endif

// 获取随机数据
#define kRandomData [NSString stringWithFormat:@"随机数据 --- %zi", arc4random_uniform(100000)]
#endif /* TJMcros_h */
