//
//  UIFont+TJFont.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIFont+TJFont.h"

@implementation UIFont (TJFont)

+(UIFont *)defaultFontOfSize12{
    return [[self class] defaultFontOfSize:12];
}

+(UIFont *)defaultFontOfSize13{
    return [[self class] defaultFontOfSize:13];
}

+(UIFont *)defaultFontOfSize14{
    return [[self class] defaultFontOfSize:14];
}

+(UIFont *)defaultFontOfSize15{
    return [[self class] defaultFontOfSize:15];
}

+(UIFont *)defaultFontOfSize16{
    return [[self class] defaultFontOfSize:16];
}

+(UIFont *)defaultFontOfSize18{
    return [[self class] defaultFontOfSize:18];
}

+(UIFont *)defaultFontOfSize20{
    return [[self class] defaultFontOfSize:20];
}

+ (UIFont *)defaultFontOfSize:(NSUInteger)size{
    return [[self class]fontOfSize:size fontName:@"HelveticaNeue"];
}

+ (UIFont *)fontOfSize:(NSInteger)size fontName:(NSString *)name{
    UIFont *font = [UIFont fontWithName:name size:size];
    if (font == nil) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)boldFontOfSize:(NSUInteger)size fontName:(NSString *)name {
    UIFont *font = [UIFont fontWithName:name size:size];
    if(font == nil) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
@end
