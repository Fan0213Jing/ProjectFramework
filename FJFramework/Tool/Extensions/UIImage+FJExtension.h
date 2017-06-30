//
//  UIImage+FJExtension.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FJExtension)
/**
 *  修改图片的背景颜色
 *
 *  @param color 对应的颜色
 *
 *  @return 修改后的图片
 */
- (UIImage *)updateImageWithColor:(UIColor *)color;

/**
 *  根据颜色生成一张图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  拉伸图片
 *
 *  @param imgName 原始图片
 *
 *  @return 返回一张拉伸的图片
 */
+ (UIImage *)resizeImage:(NSString *)imgName;

/**
 *  防止渲染，显示原始图片
 *
 *  @param imageName 图片名称
 *
 *  @return 显示原始图片
 */
+ (UIImage *)imageWithOriginalName:(NSString *)imageName;

/**
 *  压缩和旋转图片
 *
 *  @param image 原始图片
 *
 *  @return 压缩处理后的图片
 */
+ (UIImage *)compressImageWith:(UIImage *)image;

/**
 *  等比例缩放图片
 *
 *  @param image 原始图片
 *  @param width 缩放目标宽度
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)scaleImageWith:(UIImage *)image targetWidth:(CGFloat)width;

/**
 *  NSBundle中获取图片 - 不会有缓存
 *
 *  @param name 图片资源的名称
 *
 *  @return 获取的图片
 */
+ (UIImage *)imageResourceName:(NSString *)name;


/**
 *  画圆角
 *
 *  @param size 图片所在imageView的size
 *
 *  @return 圆形图片
 */
- (UIImage *)circleImage:(CGSize)size;

/**
 *  画圆角
 *
 *  @param size 图片所在imageView的size
 *
 *  @param radius 圆角半径
 *
 *  @return 圆角图片
 */
- (UIImage *)circleImage:(CGSize)size radius:(CGFloat)radius;

/**
 *  画圆角
 *
 *  @param size  图片所在imageView的size
 *  @param color 边框的颜色
 *  @param width 边框的宽度
 *
 *  @return 带边框的圆形图片
 */
- (UIImage *)circleImage:(CGSize)size color:(UIColor *)color width:(CGFloat)width;
/**
 *  画分割线
 *
 *  @return 分割线图片
 */
+ (UIImage *)drawNavgationBarSeparatorImg;


@end
