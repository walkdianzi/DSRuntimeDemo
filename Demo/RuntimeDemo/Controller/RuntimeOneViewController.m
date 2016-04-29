//
//  RuntimeOneViewController.m
//  RuntimeDemo
//
//  Created by dasheng on 16/4/28.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "RuntimeOneViewController.h"
#import <objc/runtime.h>


//一个Objective-C方法是一个简单的C函数，它至少包含两个参数—self和_cmd。所以，我们的实现函数(IMP参数指向的函数)至少需要两个参数，如下所示：
void TestMethod(id self, SEL _cmd) {
    
    // self 指实例自身地址 == id instance
    NSLog(@"This objcet is %p", self);
    
    
    /*
     class 方法实现 return object_getClass(self)
     class方法其实取到传入对象（self）的isa对象而已 self->isa 指向类对象！ %@就会打印类对象的 description 方法
     superclass 方法实现 return [self class]->superclass
     同理 self class 取到类对象 然后取到superclass %@就会打印类对象的 description 方法
     */
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    
    
    /*self是实例对象，因此self->isa == [self class](实例对象的元类) 取到类对象
     
     以下等价于Class currentClass = object_getClass(self);
     */
    Class currentClass = [self class];
    
    
    /*
     现在结构是 NSObject->NSError->TestClass
     */
    for (int i = 0; i < 4; i++) {
        
        //第0次 currentClass 是TestClass类对象
        //第1次 currentClass 是TestClass 的 metaClass
        //第2次 currentClass 是NSObject 的 metaClass(因为metaClass的isa都是指向基类NSObject的metaClass)
        //第3次 currentClass 是NSObject 的metaClass 是自身。。。。。。正如图所示
        NSLog(@"Following the isa pointer %d times gives %@ %p", i, currentClass ,currentClass);
        
        /*其实是对传入对象->isa，返回指定类的类定义
         获得metaclass 使用object_getClass(newClass)
         
         注意：我们在一个类对象调用class方法是无法获取meta-class，它只是返回类而已。
              实例对象调用class可以获取meta-class，也就是类对象
        */
        currentClass = object_getClass(currentClass);
    }
   
    //直接取到NSObject的类对象
    NSLog(@"NSObject's class is %p", [NSObject class]);
    
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
    
    /* 输出
    2016-04-28 09:49:59.381 RuntimeDemo[32170:1424756] This objcet is 0x7fff2971a6b0
    2016-04-28 09:49:59.382 RuntimeDemo[32170:1424756] Class is TestClass, super class is NSError
    2016-04-28 09:49:59.382 RuntimeDemo[32170:1424756] Following the isa pointer 0 times gives 0x7fff297383e0
    2016-04-28 09:49:59.383 RuntimeDemo[32170:1424756] Following the isa pointer 1 times gives 0x0
    2016-04-28 09:49:59.383 RuntimeDemo[32170:1424756] Following the isa pointer 2 times gives 0x0
    2016-04-28 09:49:59.383 RuntimeDemo[32170:1424756] Following the isa pointer 3 times gives 0x0
    2016-04-28 09:49:59.383 RuntimeDemo[32170:1424756] NSObject's class is 0x106770170
    2016-04-28 09:49:59.383 RuntimeDemo[32170:1424756] NSObject's meta class is 0x0
     */
}

@implementation RuntimeOneViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    /*运行时创建了一个NSError的子类TestClass，参数依次为父类，子类名，大小
     注意:newClass仅仅只是一个类对象 class object，而不是一个类实例！
     */
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    
    
    /*为这个子类添加一个方法testMetaClass，这个方法的实现是TestMetaClass函数。
     
     (IMP)TestMetaClass 意思是TestMetaClass的地址指针;
     
     "v@:" 意思是，v代表无返回值void，如果是i则代表int；@代表 id sel; : 代表 SEL _cmd;
     
     “v@:@@” 意思是，两个参数的没有返回值。
    */
    class_addMethod(newClass, @selector(testMethod), (IMP)TestMethod, "v@:");
    
    
    class_addIvar(newClass, "_testVar", sizeof(id), log2(sizeof(id)), @encode(id));
    
    /*在应用中注册由objc_allocateClassPair创建的类
     
     诸如class_addMethod，class_addIvar等函数来为新创建的类添加方法、实例变量和属性等。完成这些后，我们需要调用objc_registerClassPair函数来注册类，之后这个新类就可以在程序中使用了。
     */
    objc_registerClassPair(newClass);
    
    
    
    //------------------------------
    /*
      实例化对象 id typedef struct objc_object *id
      而类是typedef struct objc_class *Class
     */
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    
    
    //TestMetaClass是具体实现函数地址 而testMetaClass 只是方法名字
    [instance performSelector:@selector(testMethod)];
    
    NSLog(@"=================================");
    
    //从类中获取成员变量Ivar
    Ivar nameIvar = class_getInstanceVariable(newClass, "_testVar");
    //为instance的成员变量赋值
    object_setIvar(instance, nameIvar, @"齐滇大圣");
    //获取p1成员变量的值
    NSLog(@"%@",object_getIvar(instance, nameIvar));
}

@end
