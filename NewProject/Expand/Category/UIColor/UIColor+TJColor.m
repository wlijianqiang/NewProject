//
//  UIColor+TJColor.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/10.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "UIColor+TJColor.h"

@implementation UIColor (TJColor)

+ (UIColor *)colorWithHexString:(NSString *)hexString{
    if (!hexString || [hexString isEqualToString:@""])
    {
        return [UIColor blackColor];
    }
   	/* convert the string into a int */
    unsigned int colorValueR,colorValueG,colorValueB,colorValueA;
    NSString *hexStringCleared = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if(hexStringCleared.length == 3)
    {
        /* short color form */
        /* im lazy, maybe you have a better idea to convert from #fff to #ffffff */
        hexStringCleared = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                            [hexStringCleared substringWithRange:NSMakeRange(0, 1)],[hexStringCleared substringWithRange:NSMakeRange(0, 1)],
                            [hexStringCleared substringWithRange:NSMakeRange(1, 1)],[hexStringCleared substringWithRange:NSMakeRange(1, 1)],
                            [hexStringCleared substringWithRange:NSMakeRange(2, 1)],[hexStringCleared substringWithRange:NSMakeRange(2, 1)]];
    }
    if(hexStringCleared.length == 6)
    {
        hexStringCleared = [hexStringCleared stringByAppendingString:@"ff"];
    }
    hexStringCleared = [[hexStringCleared stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    /* im in hurry ;) */
    NSString *red = [hexStringCleared substringWithRange:NSMakeRange(0, 2)];
    NSString *green = [hexStringCleared substringWithRange:NSMakeRange(2, 2)];
    NSString *blue = [hexStringCleared substringWithRange:NSMakeRange(4, 2)];
    NSString *alpha = [hexStringCleared substringWithRange:NSMakeRange(6, 2)];
    
    [[NSScanner scannerWithString:red] scanHexInt:&colorValueR];
    [[NSScanner scannerWithString:green] scanHexInt:&colorValueG];
    [[NSScanner scannerWithString:blue] scanHexInt:&colorValueB];
    [[NSScanner scannerWithString:alpha] scanHexInt:&colorValueA];
    
    
    return [UIColor colorWithRed:((colorValueR)&0xFF)/255.0
                           green:((colorValueG)&0xFF)/255.0
                            blue:((colorValueB)&0xFF)/255.0
                           alpha:((colorValueA)&0xFF)/255.0];

}

+ (UIColor *)RGBColorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha{
    return  ([UIColor colorWithRed:red / 255.0 green:green / 255.0  blue:blue / 255.0  alpha:alpha]);
}
+ (UIColor *)randomColor{
    static BOOL seeded = NO;
    if (!seeded)
    {
        seeded = YES;
        (time(NULL));
    }
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
