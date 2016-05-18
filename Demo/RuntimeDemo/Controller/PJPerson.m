//
//  PJPerson.m
//  RuntimeDemo
//
//  Created by dasheng on 16/5/17.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "PJPerson.h"
#import <objc/runtime.h>
#import "ChinaPerson.h"


@implementation PJPerson{
    
    ChinaPerson *_person;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _person = [[ChinaPerson alloc] init];
    }
    return self;
}

/*--------------------第一步：动态方法解析----------------------*/
//实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    /*如果 respondsToSelector: 或 instancesRespondToSelector:方法被执行，动态方法解析器将会被首先给予一个提供该方法选择器对应的IMP的机会。
     如果你想让该方法选择器被传送到转发机制，那么就让resolveInstanceMethod:返回NO。
     */
    if (sel == @selector(resolveThisMethodDynamically)) {
        
        return NO;
    }
    return [super resolveInstanceMethod:sel];
}

/*--------------------第二步：重定向----------------------*/
//在消息转发机制执行前，Runtime 系统会再给我们一次偷梁换柱的机会，即通过重载- (id)forwardingTargetForSelector:(SEL)aSelector方法替换消息的接受者为其他对象：
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    
//    if(aSelector == @selector(resolveThisMethodDynamically)){
//        return _person;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}


/*--------------------第三步：消息转发----------------------*/

//其实在forwardInvocation:消息发送前，Runtime系统会向对象发送methodSignatureForSelector:消息，并取到返回的方法签名用于生成NSInvocation对象。所以我们在重写forwardInvocation:的同时也要重写methodSignatureForSelector:方法，否则会抛异常。
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector{
    
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];

    if (!signature){
        signature = [_person methodSignatureForSelector:selector];
    }
    return signature;
}

//每个对象都从NSObject类中继承了forwardInvocation:方法。然而，NSObject中的方法实现只是简单地调用了doesNotRecognizeSelector:。通过实现我们自己的forwardInvocation:方法，我们可以在该方法实现中将消息转发给其它对象。
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    
    if ([_person respondsToSelector:[anInvocation selector]]){
        
        [anInvocation invokeWithTarget:_person];
    }
    else{
        [super forwardInvocation:anInvocation];
    }
}

@end
