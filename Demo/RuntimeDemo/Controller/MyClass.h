//
//  MyClass.h
//  RuntimeDemo
//
//  Created by dasheng on 16/4/28.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject<NSCopying, NSCoding>

@property (nonatomic, strong) NSArray *array;



@property (nonatomic, copy) NSString *string;



- (void)method1;



- (void)method2;



+ (void)classMethod1;


@end
