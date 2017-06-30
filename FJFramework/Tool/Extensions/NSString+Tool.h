//
//  NSString+Tool.h
//  jupiter
//
//  Created by 崇庆旭 on 2016/7/9.
//  Copyright © 2016年 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString * realString(NSString * str);

CGFloat stringWidth(NSString * str , UIFont * font);

CGFloat stringHeight(NSString * str , UIFont * font);

CGSize labelSize(NSString * str , UIFont * font , CGSize size);

CGSize stringSize(NSString *string,UIFont *font,CGSize limitSize);

CGSize stringSizeWithParagraph(NSString *string,UIFont *font,NSMutableParagraphStyle *paragraph,CGSize limitSize);

CGFloat labelWidth(UILabel * label);

CGFloat labelHeight(UILabel *label);

CGFloat stringHeightWithLimitedLines(NSString *str,UIFont *font,NSInteger lines);

CGFloat stringHeightLimitedLine(NSInteger lineNum,CGFloat width,NSString *text,UIFont *font);

/**
 *  多少个中文字的宽度
 *
 *  @param font     字体
 *  @param maxCount 字数
 *
 *  @return 宽度
 */
CGFloat stringWithLimited(UIFont *font, NSInteger maxCount);

@interface NSString (Tool)

- (BOOL)charValue;      //KVC赋BOOL值crash问题

@end
