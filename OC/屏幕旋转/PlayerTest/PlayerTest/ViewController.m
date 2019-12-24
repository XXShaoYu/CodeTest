//
//  ViewController.m
//  PlayerTest
//
//  Created by sn on 2019/12/23.
//  Copyright © 2019 sn. All rights reserved.
//

#import "ViewController.h"
#import "PlayerVC.h"
#import "FullPlayerVC.h"
#import "AnimatedTrans.h"

@interface ViewController () <PlayerVCDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlayerVC *playerVC = [story instantiateViewControllerWithIdentifier:@"PlayerVC"];
    playerVC.view.frame = CGRectMake(0, 0, kScreenWidth, 300);
    playerVC.delegate = self;
    [self.view addSubview:playerVC.view];
    [self addChildViewController:playerVC];
    [playerVC didMoveToParentViewController:self];
}

- (void)fullScreenClickWithPlayerVC:(PlayerVC *)vc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FullPlayerVC *fullPlayerVC = [story instantiateViewControllerWithIdentifier:@"FullPlayerVC"];
    fullPlayerVC.transitioningDelegate = [AnimatedTrans transAnimationWithType:AnimatedTransToFullScreen fromFrame:vc.view.frame toFrame:UIScreen.mainScreen.bounds];
    [vc presentViewController:fullPlayerVC animated:YES completion:nil];
    
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
}

- (BOOL)shouldAutorotate {
    return NO;
}
@end
