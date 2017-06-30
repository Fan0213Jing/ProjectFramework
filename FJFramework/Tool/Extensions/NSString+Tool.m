//
//  NSString+Tool.m
//  jupiter
//
//  Created by 崇庆旭 on 2016/7/9.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "NSString+Tool.h"

NSString * realString(id str)
{
    if ([str isKindOfClass:[NSNull class]] || str == NULL || str == nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",str];
}

CGFloat stringWidth(NSString * str , UIFont * font)
{
    // 根据字体得到NSString的尺寸,无换行的
    CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return size.width;
}

CGFloat stringHeight(NSString * str , UIFont * font)
{
    // 根据字体得到NSString的尺寸,无换行的
    CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return size.height;
}

CGSize labelSize(NSString * str , UIFont * font , CGSize size)
{
    //根据给定的字符串,字号,label的最大尺寸来计算最大程度显示str的label的尺寸
    NSDictionary * attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize s = CGRectIntegral([realString(str) boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil]).size;
    return s;
}

CGFloat stringWithLimited(UIFont *font, NSInteger maxCount) {
    if (maxCount <= 0) {
        return 0;
    }
    NSString *str = @"";
    for (NSInteger i = 0; i < maxCount; i++) {
        str = [NSString stringWithFormat:@"%@测",str];
    }
    return [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width;
}

CGFloat stringHeightLimitedLine(NSInteger lineNum,CGFloat width,NSString *text,UIFont *font) {
    
    if (lineNum < 0) {
        return 0;
    }
    
    @autoreleasepool {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
        label.text = text;
        label.font = font;
        label.numberOfLines = lineNum;
        [label sizeToFit];
        CGFloat height = label.height;
        return height;
    }
    
}

CGSize stringSize(NSString *string,UIFont *font,CGSize limitSize) {
    return [string boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

CGSize stringSizeWithParagraph(NSString *string,UIFont *font,NSMutableParagraphStyle *paragraph,CGSize limitSize){
    return  [string boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraph} context:nil].size;
}



CGFloat labelWidth(UILabel *label){
    return stringWidth(label.text, label.font);
    
}

CGFloat labelHeight(UILabel *label){
    return stringHeight(label.text, label.font);
}

CGFloat stringHeightWithLimitedLines(NSString *str,UIFont *font,NSInteger lines) {
    CGFloat singleH = stringHeight(str, font);
    return lines * singleH;
}

@implementation NSString (Tool)

- (BOOL)charValue {
    return [realString(self) boolValue];
}


@end

