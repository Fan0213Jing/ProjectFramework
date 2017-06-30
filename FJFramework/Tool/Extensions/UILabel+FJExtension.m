//
//  UILabel+FJExtension.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "UILabel+FJExtension.h"

@implementation UILabel (FJExtension)
- (void)addShadowWithString:(NSString *)string shadowColor:(UIColor *)shadowColor shadowOffSet:(CGSize)offset stringColor:(UIColor *)textColor font:(UIFont *)font {
    if (!string) {
        return;
    }
    if (!textColor) {
        textColor = [UIColor whiteColor];
    }
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = shadowColor;
    shadow.shadowOffset = offset;
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:string];
    [attrM addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor,NSShadowAttributeName:shadow,NSVerticalGlyphFormAttributeName:@0} range:NSMakeRange(0, attrM.length)];
    self.attributedText = [attrM copy];
}

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText withAttrColor:(UIColor *)color withFont:(CGFloat )font {
    if (!attrText || !text) {
        return;
    }
    NSRange range = [text rangeOfString:attrText];
    
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [muStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:color} range:range];
    
    self.attributedText = muStr;
}

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2 withAttrColor:(UIColor *)color withFont:(CGFloat )font {
    
    
    
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [self stirng:text withSubstr:attrText1 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text2 withAttrColor:color withFont:font muStr:muStr];
    
    
    self.attributedText = muStr;
}

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2  andText3:(NSString *)text3 withAttrColor:(UIColor *)color withFont:(CGFloat )font {
    
    
    
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [self stirng:text withSubstr:attrText1 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text2 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text3 withAttrColor:color withFont:font muStr:muStr];
    
    self.attributedText = muStr;
}

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2  andText3:(NSString *)text3 andText4:(NSString *)text4 withAttrColor:(UIColor *)color withFont:(CGFloat )font {
    
    
       NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [self stirng:text withSubstr:attrText1 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text2 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text3 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text4 withAttrColor:color withFont:font muStr:muStr];
    
    self.attributedText = muStr;
}


- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2 andText3:(NSString *)text3 andText4:(NSString *)text4 andText5:(NSString *)text5 withAttrColor:(UIColor *)color withFont:(CGFloat )font {
    
    
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [self stirng:text withSubstr:attrText1 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text2 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text3 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text4 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text5 withAttrColor:color withFont:font muStr:muStr];
    
    self.attributedText = muStr;
}



-(void)stirng:(NSString *)str withSubstr:(NSString *)subStr withAttrColor:(UIColor *)color withFont:(CGFloat )font muStr:(NSMutableAttributedString *)muStr{
    
    NSRange range = [str rangeOfString:[NSString stringWithFormat:@"%@",subStr]];
    
    [muStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:color} range:range];
    
    if ([str componentsSeparatedByString:subStr].count == 1) {
        return;
    }
    
    for (NSInteger i = 0; i < str.length; i += range.length) {
        
        if (i < str.length - range.length) {
            
            NSString *sub = [str substringWithRange:NSMakeRange(i, range.length)];
            
            NSRange subRange = NSMakeRange(i, range.length);
            
            if ([sub isEqualToString:subStr]) {
                
                [muStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:color} range:subRange];
                
            }
            
        }
    }
}


@end
