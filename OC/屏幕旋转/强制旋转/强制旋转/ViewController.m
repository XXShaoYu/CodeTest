//
//  ViewController.m
//  强制旋转
//
//  Created by sn on 2019/12/25.
//  Copyright © 2019 sn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    // Do any additional setup after loading the view.
}

//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
//状态栏显示／隐藏
-(BOOL)prefersStatusBarHidden{
    return NO;
}

//强制转屏（这个方法最好放在BaseVController中）
- (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        // 从2开始是因为前两个参数已经被selector和target占用
        [invocation setArgument:&orientation atIndex:2];
        [invocation invoke];
    }
}
//必须返回YES
- (BOOL)shouldAutorotate{
    return YES;
}
//旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}

//- (BOOL)shouldAutorotate{
//    return NO;
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscapeRight;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeRight;
//}


@end
