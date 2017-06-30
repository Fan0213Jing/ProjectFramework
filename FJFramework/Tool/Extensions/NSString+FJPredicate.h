//
//  NSString+FJPredicate.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FJPredicate)
//1. 验证手机号
- (BOOL)IsTruePhoneNum;  // YES 代表正确
//2. 验证身份证号
- (BOOL)IsTrueIdCardNum; // YES 代表正确
//3. 邮箱的有效性

- (BOOL)isEmailAddress;  // YES 代表正确
@end
