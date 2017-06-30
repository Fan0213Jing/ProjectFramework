//
//  UILabel+FJExtension.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FJExtension)
/**
 *  为label的文字添加阴影
 *
 *  @param string label的字符串
 *  @param shadowColor  阴影的颜色
 *  @param offset 阴影的偏移量
 *  @param textColor  文字的颜色
 *  @param font   字号
 */
- (void)addShadowWithString:(NSString *)string shadowColor:(UIColor *)shadowColor shadowOffSet:(CGSize)offset stringColor:(UIColor *)textColor font:(UIFont *)font;

/**
 为label添加富文本
 
 @param text label原来的文字
 @param attrText 需要被富文本的文字
 @param color 文字颜色
 @param font 文字字号
 */
- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText withAttrColor:(UIColor *)color withFont:(CGFloat )font;

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2 withAttrColor:(UIColor *)color withFont:(CGFloat )font;
- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2  andText3:(NSString *)text3 andText4:(NSString *)text4 withAttrColor:(UIColor *)color withFont:(CGFloat )font;

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2 andText3:(NSString *)text3 andText4:(NSString *)text4 andText5:(NSString *)text5 withAttrColor:(UIColor *)color withFont:(CGFloat )font ;
- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2  andText3:(NSString *)text3 withAttrColor:(UIColor *)color withFont:(CGFloat )font ;
@end
