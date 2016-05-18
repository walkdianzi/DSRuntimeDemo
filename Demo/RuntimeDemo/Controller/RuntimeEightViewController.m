//
//  RuntimeEightViewController.m
//  RuntimeDemo
//
//  Created by dasheng on 16/5/17.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "RuntimeEightViewController.h"
#import "ChinaPerson.h"

@interface RuntimeEightViewController ()

@end

@implementation RuntimeEightViewController

/*
 我们可以通过分别重载resolveInstanceMethod:和resolveClassMethod:方法分别添加实例方法实现和类方法实现。
 因为当 Runtime 系统在Cache和方法分发表中（包括超类）找不到要执行的方法时，Runtime会调用resolveInstanceMethod:或resolveClassMethod:来给程序员一次动态添加方法实现的机会。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*这里我们执行了一个方法resolveThisMethodDynamically，当找不到对应的方法的时候，
    我们使用resolveInstanceMethod:来动态添加方法实现
     */
    ChinaPerson  *person = [[ChinaPerson alloc] init];
    [person performSelector:@selector(resolveThisMethodDynamically)];
    [ChinaPerson learnClass:@"呵呵呵"];
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
