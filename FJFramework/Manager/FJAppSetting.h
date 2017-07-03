//
//  FJAppSetting.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJAppSetting : NSObject

/**
 *  用户积分
 */
@property (nonatomic, assign) NSInteger accumulate;
/**
 *  用户的Id 会根据是否有用户Id判断用户是否登录
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  用户最新登录时间
 */
@property (nonatomic, copy) NSString *loginTime;
/**
 *  用户头像地址
 */
@property (nonatomic, copy) NSString *imgPath;
/**
 *  用户的手机号
 */
@property (nonatomic, copy) NSString *userPhone;
/**
 *  用户名
 */
@property (nonatomic, copy) NSString *userName;





+ (instancetype)appsetting;

- (void)logoutAction;

@end
