//
//  RuntimeFourViewController.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/28.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "RuntimeFourViewController.h"
#import "MyClass.h"
#import <objc/runtime.h>

@implementation RuntimeFourViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    MyClass *myClass = [[MyClass alloc] init];
    
    unsigned int outCount = 0;
    
    //myClass为实例对象，cls为类对象
    Class cls = myClass.class;
    
    
    
    // 类名
    NSLog(@"class name: %s", class_getName(cls));
    
    NSLog(@"==========================================================");
    
    
    // 父类
    
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    
    NSLog(@"==========================================================");
    
    
    
    // 是否是元类
    
    NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
    
    NSLog(@"==========================================================");
    
    
    
    Class meta_class = objc_getMetaClass(class_getName(cls));
    
    NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
    
    NSLog(@"==========================================================");
    
    
    
    // 变量实例大小
    
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    
    NSLog(@"==========================================================");
    
    
    
    // 成员变量
    
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        Ivar ivar = ivars[i];
        
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
        
    }
    
    free(ivars);
    
    
    //获取类中指定名称实例成员变量的信息
    Ivar string = class_getInstanceVariable(cls, "_string");
    
    if (string != NULL) {
        
        NSLog(@"instace variable %s", ivar_getName(string));
        
    }
    
    
    
    NSLog(@"==========================================================");
    
    
    
    // 属性操作
    
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSLog(@"property's name: %s", property_getName(property));
        
    }
    
    
    
    free(properties);
    
    
    // 获取指定的属性
    objc_property_t array = class_getProperty(cls, "array");
    
    if (array != NULL) {
        
        NSLog(@"property %s", property_getName(array));
        
    }
    
    
    
    NSLog(@"==========================================================");
    
    
    
    // 方法操作
    
    Method *methods = class_copyMethodList(cls, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        Method method = methods[i];
        
        NSLog(@"method's signature: %s", method_getName(method));
        
    }
    
    
    
    free(methods);
    
    
    
    // 获取实例方法
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    
    if (method1 != NULL) {
        
        NSLog(@"method %s", method_getName(method1));
        
    }
    
    
    // 获取类方法
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    
    if (classMethod != NULL) {
        
        NSLog(@"class method : %s", method_getName(classMethod));
        
    }
    
    
    
    //类实例是否响应指定的selector
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    
    
    
    //该函数在向类实例发送消息时会被调用，并返回一个指向方法实现函数的指针。这个函数会比method_getImplementation(class_getInstanceMethod(cls, name))更快。返回的函数指针可能是一个指向runtime内部的函数，而不一定是方法的实际实现。例如，如果类实例无法响应selector，则返回的函数指针将是运行时消息转发机制的一部分。
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    
    imp();
    
    
    NSLog(@"==========================================================");
    
    
    
    // 协议
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    
    Protocol * protocol;
    
    for (int i = 0; i < outCount; i++) {
        
        protocol = protocols[i];
        
        NSLog(@"protocol name: %s", protocol_getName(protocol));
        
    }
    
    
    
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    
    
    
    NSLog(@"==========================================================");
}

@end
