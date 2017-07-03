//
//  FJAppSetting.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJAppSetting.h"

#define KUSERID         @"KUSERID"
#define KUSERPHONE      @"KUSERPHONE"
#define KUSERNAME       @"KUSERNAME"
#define KUSERACCUMULATE @"KUSERACCUMULATE"
#define KUSERLOGINTIME  @"KUSERLOGINTIME"
#define KUSERIMGPATH    @"KUSERIMGPATH"

@implementation FJAppSetting
+ (instancetype)appsetting {
    static FJAppSetting * setting ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setting = [[FJAppSetting alloc] init];
        [setting updateSettings];
    });
    
    return setting;
}
- (void)updateSettings {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    self.userName = [defaults stringForKey:KUSERNAME];
    
    self.userId = [defaults stringForKey:KUSERID];
    
    self.userPhone = [defaults stringForKey:KUSERPHONE];
    
    self.imgPath = [defaults stringForKey:KUSERIMGPATH];
    
    self.loginTime = [defaults stringForKey:KUSERLOGINTIME];
    
    self.accumulate = [defaults integerForKey:KUSERACCUMULATE];
    
    [defaults synchronize];

}
- (void)logoutAction {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.userId     = nil;
    self.userName   = nil;
    self.loginTime  = nil;
    self.imgPath    = nil;
    self.accumulate = 0;
    
    [defaults removeObjectForKey:KUSERID];
    [defaults removeObjectForKey:KUSERNAME];
    [defaults removeObjectForKey:KUSERACCUMULATE];
    [defaults removeObjectForKey:KUSERLOGINTIME];
    [defaults removeObjectForKey:KUSERIMGPATH];
    
    [defaults synchronize];

}


@end
