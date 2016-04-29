//
//  RuntimeSevenViewController.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/29.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "RuntimeSevenViewController.h"
#import "ChinaPerson+HangzhouPerson.h"
#import "ChinaPerson.h"

@implementation RuntimeSevenViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    ChinaPerson *person = [[ChinaPerson alloc] init];
    person.hangzhouName = @"动态给分类添加属性成功";
    NSLog(@"%@",person.hangzhouName);
}

@end
