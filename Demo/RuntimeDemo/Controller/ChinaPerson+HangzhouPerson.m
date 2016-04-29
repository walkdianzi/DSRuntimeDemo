//
//  ChinaPerson+HangzhouPerson.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/29.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "ChinaPerson+HangzhouPerson.h"
#import <objc/runtime.h>

static const NSString * HangzhouPersonKey= @"HangzhouPersonKey";

@implementation ChinaPerson (HangzhouPerson)


- (void)setHangzhouName:(NSString *)hangzhouName{
    
    objc_setAssociatedObject(self, &HangzhouPersonKey, hangzhouName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)hangzhouName{
    
    return objc_getAssociatedObject(self, &HangzhouPersonKey);
}

@end
