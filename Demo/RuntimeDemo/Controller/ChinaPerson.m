//
//  ChinaPerson.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/28.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "ChinaPerson.h"
#import <objc/runtime.h>

void dynamicMethodIMP(id self, SEL _cmd) {
    
    NSLog(@"动态方法解析");
}

@implementation ChinaPerson{
    
    NSString *_myName;
}

//-----------------Eight中用到-------------------------

//实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    /*如果 respondsToSelector: 或 instancesRespondToSelector:方法被执行，动态方法解析器将会被首先给予一个提供该方法选择器对应的IMP的机会。
    如果你想让该方法选择器被传送到转发机制，那么就让resolveInstanceMethod:返回NO。
     */
    if (sel == @selector(resolveThisMethodDynamically)) {
        class_addMethod([self class], sel, (IMP) dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//当没有此方法的时候，会执行dynamicMethodIMP中的方法实现
- (void)resolveThisMethodDynamically{
    
    NSLog(@"ChinaPerson: 没用动态方法解析");
}


//类方法
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(learnClass:)) {
        class_addMethod(object_getClass([self class]), sel, class_getMethodImplementation(object_getClass(self), @selector(myClassMethod:)), "v@:");
        return YES;
    }
    return [class_getSuperclass([self class]) resolveClassMethod:sel];
}

+ (void)myClassMethod:(NSString *)string {
    NSLog(@"myClassMethod = %@", string);
}


//------------------Five,Six------------------------

- (NSString *)sayMyName{
    
    NSLog(@"这里myName的值改为 %@",_myName);
    return @"我是sayMyName";
}

- (NSString *)replaceSayMyName{
    
    return @"我是replaceSayMyName";
}

@end
