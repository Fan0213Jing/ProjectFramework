//
//  UIView+FJHUD.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FJHUD)
- (void)showHUDWithText:(NSString *)text withYOffSet:(CGFloat)yOffSet;

-(void)showHUD;
-(void)hideHUD;
@end
