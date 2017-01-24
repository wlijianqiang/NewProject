//
//  TJModel.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/23.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
/**
 注意:统一处理各种转换情况，Model类都要继承此类
 */
@interface TJModel : NSObject <NSCoding>
/**
 通过字典来创建一个模型
 @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 
 @return 新建的对象
 */
+ (nullable instancetype)tj_modelWithKeyValues:(nullable id)keyValues;

/**
 通过字典数组来创建一个模型数组
 
 @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 
 @return 模型数组
 */
+ (nullable NSMutableArray *)tj_modelArrayWithKeyValuesArray:(nullable id)keyValuesArray;
/**
 将模型转换成字典
 @return 字典
 */

- (nullable NSMutableDictionary *)tj_keyValues;

/**
 通过模型数组来创建一个字典数组
 
 @param modelArray 模型数组
 
 @return 字典数组
 */
+ (nullable NSMutableArray *)tj_keyValuesArrayWithModelArray:(nullable NSArray *)modelArray;

/**
 将字典的键值对转成模型属性
 
 @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 
 @return 模型
 */
- (nullable instancetype)tj_setKeyValues:(nullable id)keyValues;

/**
 转换为JSON 字符串
 
 @return JSON 字符串
 */
- (nullable NSString *)tj_JSONString;
@end
