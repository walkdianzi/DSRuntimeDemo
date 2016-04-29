//
//  RuntimeFiveViewController.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/28.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "RuntimeFiveViewController.h"
#import <objc/runtime.h>
#import "ChinaPerson.h"

@interface RuntimeFiveViewController(){
    
}

@property(nonatomic, strong)ChinaPerson  *person;

@end

@implementation RuntimeFiveViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.person = [[ChinaPerson alloc] init];
    
    //相当于可以改变私有变量
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.person class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        if ([name isEqualToString:@"_myName"]) {
            object_setIvar(self.person, var, @"我叫齐滇大圣");
            break;
        }
    }
    
    [self.person sayMyName];
}

@end
