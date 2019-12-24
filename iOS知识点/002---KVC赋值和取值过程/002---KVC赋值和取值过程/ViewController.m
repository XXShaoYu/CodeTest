//
//  ViewController.m
//  002---KVC赋值和取值过程
//
//  Created by cooci on 2018/12/21.
//  Copyright © 2018 cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    LGPerson *p = [[LGPerson alloc] init];
    
    // setValue:forKey: 依次会调用 setName:, _setName:, setIsName:, setPrimitiveName: 方法
    // 如果都没有实现，依次对  _name, _isName, name, isName 赋值
    [p setValue:@"a" forKey:@"name"];
//    [p setValue:nil forKey:@"a"];
    //[p setValue:@"subject" forKey:@"subject"];
    
//    NSLog(@"%@-%@-%@-%@",p->name,p->isName,p->_name,p->_isName);

//    p->_name   = @"_name";
//    p->_isName = @"_isName"; // MAP -- KEY - VALUE
//
//    p->name    = @"name";
//    p->isName  = @"isName";

    // valueForKey: 依次会调用 get Name, name, isName, _name 方法
    // 如果都不实现，依次返回 _name, _isName, name, isName
    NSLog(@"%@",[p valueForKey:@"name"]); // 方法 getName
}

@end
