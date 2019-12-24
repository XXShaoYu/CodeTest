
//
//  OtherTargert.m
//  002-强引用
//
//  Created by sn on 2019/11/21.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "OtherTargert.h"

@interface OtherTargert ()
@property (nonatomic, weak) UIViewController *vc;
@end

@implementation OtherTargert
- (instancetype)initWithVC:(UIViewController *)vc {
    self = [super init];
    if (!self) return nil;
    
    self.vc = vc;
    
    return self;
}
- (void)fireHome{
    static int num;
    num++;
    NSLog(@"hello word - %d",num);
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}
@end
