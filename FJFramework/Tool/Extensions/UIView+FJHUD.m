//
//  UIView+FJHUD.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "UIView+FJHUD.h"
#import <objc/runtime.h>
static const void *HUDLabelKey = &HUDLabelKey;

@implementation UIView (FJHUD)
- (void)setHUD:(UILabel *)hud{
    
    if (hud) {
        hud.height += 20;
        
        hud.textAlignment = NSTextAlignmentCenter;
        hud.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    }
    objc_setAssociatedObject(self,  HUDLabelKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UILabel *)getHUDLabel{
    
    return objc_getAssociatedObject(self, HUDLabelKey);
}

- (void)removeHud{
    
    UILabel *la = [self getHUDLabel];
    [la removeFromSuperview];
    
}

- (void)showHUDWithText:(NSString *)text withYOffSet:(CGFloat)yOffSet {
    
    
    UILabel * label = [self getHUDLabel];
    if (!label) {
        label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.layer.cornerRadius = 8;
        
        
    }
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    label.text = text;
    
    
    CGFloat labelW = labelSize(label.text, label.font, CGSizeMake(ScreenWidth, MAXFLOAT)).width;
    CGFloat labelH = labelSize(label.text, label.font, CGSizeMake(ScreenWidth, MAXFLOAT)).height;
    
    if (labelW >= ScreenWidth - 60) {
        label.frame = CGRectMake((ScreenWidth - labelW)/2 , (ScreenHeight - labelH) / 3 + yOffSet, labelW , labelH);
    } else {
        label.frame = CGRectMake((ScreenWidth - labelW - 60)/2 , (ScreenHeight - labelH) / 3 + yOffSet, labelW + 60, labelH);
    }
    
    
    [self setHUD:label];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeHud];
    });
    
    
    
}

-(void)showHUD {
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

-(void)hideHUD {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}


@end
