//
//  FullPlayerVC.m
//  PlayerTest
//
//  Created by sn on 2019/12/24.
//  Copyright © 2019 sn. All rights reserved.
//

#import "FullPlayerVC.h"
#import "AnimatedTrans.h"

@interface FullPlayerVC ()

@end

@implementation FullPlayerVC

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transitioningDelegate = [AnimatedTrans transAnimationWithType:AnimatedTransMissFullScreen fromFrame:self.view.frame toFrame:_missToFrame];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)orientationChanged {
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    NSLog(@"%d", deviceOrientation);
}

- (IBAction)exitFullScreenBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate {
    return YES;
}

//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

@end
