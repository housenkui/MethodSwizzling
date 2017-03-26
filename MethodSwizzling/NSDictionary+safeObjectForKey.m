//
//  NSDictionary+safeObjectForKey.m
//  MethodSwizzling
//
//  Created by Code_Hou on 2017/3/26.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "NSDictionary+safeObjectForKey.h"
#import <objc/runtime.h>
@implementation NSDictionary (safeObjectForKey)

+ (void)load{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(objectForKey:);
        
        SEL swizzledSelector = @selector(safeObjectForKey:);
        
        Class class = [self class];
        
        //拿到实例方法实现的函数指针
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod  =class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else{
            
            method_exchangeImplementations(originalMethod, swizzledMethod);

        }
        
        
    });
    
}

//FIXME:为什么带有返回值得方法使用swizzling 不行呢？

- (id)safeObjectForKey:(NSString *)key{
    
    id  obj = [self safeObjectForKey:key];
    
    if (!obj) {
        
        NSLog(@"key为%@字典对应的值是nil",key);
        
        return nil;
    }
    return obj;
}
@end
