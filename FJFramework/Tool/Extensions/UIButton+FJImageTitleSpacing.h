//
//  UIButton+FJImageTitleSpacing.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, FJButtonEdgeInsetsStyle) {
    FJButtonEdgeInsetsStyleTop, // image在上，label在下
    FJButtonEdgeInsetsStyleLeft, // image在左，label在右
    FJButtonEdgeInsetsStyleBottom, // image在下，label在上
    FJButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (FJImageTitleSpacing)
/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)buttonWithEdgeInsetsStyle:(FJButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
