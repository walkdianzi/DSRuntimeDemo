//
//  RuntimeThreeViewController.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/28.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "RuntimeThreeViewController.h"
#import <objc/runtime.h>


@implementation RuntimeThreeViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    int numClasses;
    
    Class * classes = NULL;
    
    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        classes = malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        
        NSLog(@"number of classes: %d", numClasses);
        
        for (int i = 0; i < numClasses; i++) {
            
            Class cls = classes[i];
            NSLog(@"class name: %s", class_getName(cls));
        }
        
        free(classes);
    }
}

@end
