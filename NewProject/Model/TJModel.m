//
//  TJModel.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/23.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJModel.h"
#import "MJExtension.h"

@implementation TJModel

+ (instancetype)tj_modelWithKeyValues:(id)keyValues{
    return [[self class] mj_objectWithKeyValues:keyValues];
}

+ (NSMutableArray *)tj_modelArrayWithKeyValuesArray:(id)keyValuesArray{
    return [[self class] mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

- (NSMutableDictionary *)tj_keyValues{
    return [self mj_keyValues];
}

+ (NSMutableArray *)tj_keyValuesArrayWithModelArray:(NSArray *)modelArray{
    return [[self class] mj_keyValuesArrayWithObjectArray:modelArray];
}

- (instancetype)tj_setKeyValues:(id)keyValues{
    return [self mj_setKeyValues:keyValues];
}

- (NSString *)tj_JSONString{
    return [self mj_JSONString];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        [self mj_decode:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self mj_encode:aCoder];
}
@end
