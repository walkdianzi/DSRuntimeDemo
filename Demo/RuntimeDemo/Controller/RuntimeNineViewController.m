//
//  RuntimeNineViewController.m
//  RuntimeDemo
//
//  Created by dasheng on 16/5/17.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "RuntimeNineViewController.h"
#import "ChinaPerson.h"
#import "PJPerson.h"

@interface RuntimeNineViewController ()

@end

@implementation RuntimeNineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PJPerson *person = [[PJPerson alloc] init];
    [person performSelector:@selector(resolveThisMethodDynamically)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
