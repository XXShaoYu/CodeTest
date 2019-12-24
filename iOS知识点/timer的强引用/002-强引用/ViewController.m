//
//  ViewController.m
//  002-强引用
//
//  Created by cooci on 2019/4/10.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGTimerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LGTimerViewController *vc = LGTimerViewController.alloc.init;
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
}

@end
