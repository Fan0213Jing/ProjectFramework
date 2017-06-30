//
//  UIControl+FJTouchInterval.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (FJTouchInterval)
/**
 * 点击按钮间隔时间（防止按钮快速重复点击）
 * 不设置或者设置为0.0的时候  默认是不延迟
 */
@property (nonatomic, assign) CGFloat touchInterval;


@end
