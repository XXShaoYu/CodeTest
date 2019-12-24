//
//  LGPerson.m
//  002---KVC赋值过程
//
//  Created by cooci on 2018/12/18.
//  Copyright © 2018 cooci. All rights reserved.
//

#import "LGPerson.h"

@implementation LGPerson

#pragma mark - set相关
//- (void)setName:(NSString *)name{
//    NSLog(@"%s",__func__);
//}
//
//- (void)_setName:(NSString *)name{
//    NSLog(@"%s",__func__);
//}
//
//- (void)setIsName:(NSString *)isName{
//    NSLog(@"%s",__func__);
//}

//- (void)setPrimitiveName:(NSString *)name {
//    NSLog(@"%s",__func__);
//}

#pragma mark - get相关
// 取值的过程 -- 猜源码


// 底层苹果会默认实现很多方法
// 没有源码 -- set --
// get<Key>
// name
// isName
// _name

// name 赋值
// 存的时候 不是唯一 -- name 
// _name, _is<Key>, <key>, or is<Key>,
// map _name cooci

// 取值
// _name getter

//- (NSString *)getName{
//    NSLog(@"%s",__func__);
//    return NSStringFromSelector(_cmd);
//}
//- (NSString *)name{
//    NSLog(@"%s",__func__);
//    return NSStringFromSelector(_cmd);
//}

//- (NSString *)isName{
//    NSLog(@"%s",__func__);
//    return NSStringFromSelector(_cmd);
//}

//- (NSString *)_name{
//    NSLog(@"%s",__func__);
//    return NSStringFromSelector(_cmd);
//}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    NSLog(@"%s %@ 来了", __func__, key);
//}
//
//- (nullable id)valueForUndefinedKey:(NSString *)key {
//    NSLog(@"%s %@ 来了", __func__, key);
//    return nil;
//}
//
//- (void)setNilValueForKey:(NSString *)key {
//    // 如果key 对应的变量是基础类型， 并且你setValue:nil forKey: 那么会走到这里
//    NSLog(@"%s %@ 来了", __func__, key);
//}

#pragma mark - 关闭或开启实例变量赋值
// 是否开启间接访问
// LLVM -- _name
// name
// 动态性
+ (BOOL)accessInstanceVariablesDirectly{
    return YES;
}


@end
