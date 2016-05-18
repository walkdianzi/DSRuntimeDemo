//
//  RuntimeTwoViewController.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/28.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "RuntimeTwoViewController.h"
#import <objc/runtime.h>

void replaceMethod(id self, SEL _cmd) {
 
    NSLog(@"replaceMethod");
}

@interface RuntimeObject : NSObject

- (void)orginMethod;

@end

@implementation RuntimeObject

-(void)replaceMethod{
    
    Class strcls = [self class];
    SEL  orginSelector = @selector(orginMethod);
    class_replaceMethod(strcls, orginSelector, (IMP)replaceMethod, "v@:");
}

- (void)orginMethod{
    
    NSLog(@"orginMethod");
}

@end

@implementation RuntimeTwoViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];

    RuntimeObject *obj = [[RuntimeObject alloc]init];
    [obj replaceMethod];
    [obj orginMethod];
}
@end
