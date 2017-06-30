//
//  UIImageView+FJPlayGif.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FJPlayGif)
/** 解析gif文件数据的方法 block中会将解析的数据传递出来 */
- (void)getGifImageWithUrl:(NSURL *)url returnData:(void(^)(NSArray<UIImage *> * imageArray,NSArray<NSNumber *>*timeArray,CGFloat totalTime, NSArray<NSNumber *>* widths, NSArray<NSNumber *>* heights))dataBlock;

/** 为UIImageView添加一个设置gif图内容的方法： */
- (void)setGifImage:(NSURL *)imageUrl;



// 播放GIF
- (void)playGifAnim:(NSArray *)images;
// 停止动画
- (void)stopGifAnim;


@end
