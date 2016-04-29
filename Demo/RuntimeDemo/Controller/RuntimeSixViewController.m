//
//  RuntimeSixViewController.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/28.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "RuntimeSixViewController.h"
#import <objc/runtime.h>
#import "ChinaPerson.h"

@interface RuntimeSixViewController(){
    
}

@property(nonatomic, strong)ChinaPerson  *person;

@end

@implementation RuntimeSixViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.person = [[ChinaPerson alloc] init];
    
    Method m1 = class_getInstanceMethod([self.person class], @selector(sayMyName));
    Method m2 = class_getInstanceMethod([self.person class], @selector(replaceSayMyName));
    
    //添加一个新方法sayMyName，如果不存在sayMyName方法，则返回YES；如果存在则返回NO。
    BOOL success = class_addMethod([self.person class], @selector(sayMyName), method_getImplementation(m2), method_getTypeEncoding(m2));
    
    //如果方法add成功了则把replaceSayMyName的函数实现设置为m1
    //失败了则说明方法已存在，就直接交换两个方法实现
    if (success) {
        class_replaceMethod([self.person class], @selector(replaceSayMyName), method_getImplementation(m1), method_getTypeEncoding(m1));
    } else {
        method_exchangeImplementations(m1, m2);
    }
    

    NSString *secondName = [self.person sayMyName];
    
    NSLog(@"secondName is %@",secondName);
}

@end
