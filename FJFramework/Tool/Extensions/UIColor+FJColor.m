//
//  UIColor+FJColor.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "UIColor+FJColor.h"

@implementation UIColor (FJColor)
+ (UIColor *)colorWithHexString:(NSString *)color {
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
  
     // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    
    //红色，字符串的前2位
    range.length = 2;
    NSString *redString = [color substringWithRange:range];
    
    //绿色，字符串的中间2位
    range.location = 2;
    NSString *greenString = [color substringWithRange:range];
    
    //蓝色，字符串的后面2位
    range.location = 4;
    NSString *blueString = [color substringWithRange:range];
    
    NSString *alphaString = @"ff";
    if (color.length == 8) {
        range.location = 6;
        alphaString = [color substringWithRange:range];
    }
    //三原色
    unsigned int r;
    unsigned int g;
    unsigned int b;
    unsigned int alpha;
    //把对应字符串代表的16进制转换成10进制浮点数
    [[NSScanner scannerWithString:redString] scanHexInt:&r];
    [[NSScanner scannerWithString:greenString] scanHexInt:&g];
    [[NSScanner scannerWithString:blueString] scanHexInt:&b];
    [[NSScanner scannerWithString:alphaString] scanHexInt:&alpha];
    
    
    if ([UIDevice currentDevice].systemVersion.integerValue >= 10 ) {
        return [UIColor colorWithDisplayP3Red:1.0f*r/255.0f green:1.0f*g/255.0f blue:1.0f*b/255.0f alpha:1.0f*alpha/255.0f];
    } else {
        return [UIColor colorWithRed:1.0f*r/255.0f green:1.0f*g/255.0f blue:1.0f*b/255.0f alpha:1.0f*alpha/255.0f];
    }
    
    
}

@end
