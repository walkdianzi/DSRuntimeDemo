//
//  ChinaPerson.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/28.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "ChinaPerson.h"

@implementation ChinaPerson{
    
    NSString *_myName;
}

- (NSString *)sayMyName{
    
    NSLog(@"这里myName的值改为 %@",_myName);
    return @"我是sayMyName";
}

- (NSString *)replaceSayMyName{
    
    return @"我是replaceSayMyName";
}

@end
