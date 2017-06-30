//
//  UIControl+FJTouchInterval.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "UIControl+FJTouchInterval.h"

@implementation UIControl (FJTouchInterval)
- (CGFloat)touchInterval
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setTouchInterval:(CGFloat)touchInterval
{
    objc_setAssociatedObject(self, @selector(touchInterval), @(touchInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    //获取着两个方法
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method myMethod = class_getInstanceMethod(self, @selector(fj_sendAction:to:forEvent:));
    SEL mySEL = @selector(fj_sendAction:to:forEvent:);
    
    //添加方法进去
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    
    //如果方法已经存在了
    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, myMethod);
    }
}

- (void)fj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.touchInterval > 0.0) {
        self.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.touchInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });
    }else {
        // 不做处理
    }
    
    [self fj_sendAction:action to:target forEvent:event];
}


@end
