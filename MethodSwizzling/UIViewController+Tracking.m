//
//  UIViewController+Tracking.m
//  MethodSwizzling
//
//  Created by Code_Hou on 2017/3/26.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>
@implementation UIViewController (Tracking)
+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class =[self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector =@selector(hsk_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        //选择器使用原先的，但是函数实现的指针使用现在的。
        BOOL didAddMethod = class_addMethod(class
                                            , originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        
    });
}


#pragma mark---Method Swizzling
//改变一个实例的方法

- (void)hsk_viewWillAppear:(BOOL)animated{
    
    [self hsk_viewWillAppear:animated];
    
    NSLog(@" %@  %@",self,NSStringFromSelector(_cmd));
}
















@end
