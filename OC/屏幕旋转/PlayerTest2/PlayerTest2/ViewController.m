//
//  ViewController.m
//  PlayerTest2
//
//  Created by sn on 2019/12/24.
//  Copyright © 2019 sn. All rights reserved.
//

#import "ViewController.h"

static CGFloat AnimationDuration = 0.3;//旋转动画执行时间

@interface ViewController ()
@property (nonatomic, nullable, strong) UIView *playerView;//播放器视图
@property (nonatomic, nullable, strong) UIButton *btnFullScreen;
@property (nonatomic, nullable, strong) UIView *playerSuperView;//记录播放器父视图
@property (nonatomic, assign) CGRect playerFrame;//记录播放器原始frame
@property (nonatomic, assign) BOOL isFullScreen;//记录是否全屏
@end

@implementation ViewController


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.playerView addSubview:self.btnFullScreen];
    UIScrollView *scrollView = [UIScrollView.alloc initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)*2);
    self.playerView.frame = CGRectMake(0, 300, CGRectGetWidth(scrollView.frame), 300);
    [scrollView addSubview:self.playerView];
    [self.view addSubview:scrollView];
    
    //开启和监听 设备旋转的通知
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

//设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下平躺");
            break;
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
            if (self.isFullScreen) {
                [self toOrientation:UIInterfaceOrientationLandscapeRight];
            }
            
            NSLog(@"屏幕向左横置");
            break;
        case UIDeviceOrientationLandscapeRight:
            if (self.isFullScreen) {
                [self toOrientation:UIInterfaceOrientationLandscapeLeft];
            }
            
            NSLog(@"屏幕向右橫置");
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"屏幕直立");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"屏幕直立，上下顛倒");
            break;
        default:
            NSLog(@"无法辨识");
            break;
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

#pragma mark - private method

- (void)fullScreenAction:(UIButton *)sender {
    if (self.isFullScreen) {    //如果是全屏，点击按钮进入小屏状态
        [self changeToOriginalFrame];
    } else {    //不是全屏，点击按钮进入全屏状态
        [self changeToFullScreen];
    }
}

- (void)changeToOriginalFrame {
    if (!self.isFullScreen) {
        return;
    }
    
    [UIView animateWithDuration:AnimationDuration animations:^{
        [self toOrientation:UIInterfaceOrientationPortrait];
        self.playerView.frame = self.playerFrame;
        [self.playerView removeFromSuperview];
        [self.playerSuperView addSubview:self.playerView];
    } completion:^(BOOL finished) {
        self.isFullScreen = NO;
    }];
}

- (void)changeToFullScreen {
    if (self.isFullScreen) {
        return;
    }
    
    //记录播放器视图的父视图和原始frame值,在实际项目中，可能会嵌套子视图，所以播放器的superView有可能不是self.view，所以需要记录父视图
    self.playerSuperView = self.playerView.superview;
    self.playerFrame = self.playerView.frame;
    
    CGRect rectInWindow = [self.playerView convertRect:self.playerView.bounds toView:[UIApplication sharedApplication].keyWindow];
    [self.playerView removeFromSuperview];
    
    self.playerView.frame = rectInWindow;
    [[UIApplication sharedApplication].keyWindow addSubview:self.playerView];
    
    //执行旋转动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationLandscapeRight) {
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
        } else {
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
        }
        
        self.playerView.bounds = CGRectMake(0, 0, CGRectGetHeight([UIApplication sharedApplication].keyWindow.bounds), CGRectGetWidth([UIApplication sharedApplication].keyWindow.bounds));
        self.playerView.center = CGPointMake(CGRectGetMidX([UIApplication sharedApplication].keyWindow.bounds), CGRectGetMidY([UIApplication sharedApplication].keyWindow.bounds));
        
    } completion:^(BOOL finished) {
        self.isFullScreen = YES;
    }];
}

- (void)toOrientation:(UIInterfaceOrientation)orientation {
    // 获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    // 判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == orientation) { return; }
    
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    
    // 获取旋转状态条需要的时间:
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:AnimationDuration];
    // 更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    // 给你的播放视频的view视图设置旋转
    self.playerView.transform = CGAffineTransformIdentity;
    self.playerView.transform = [self getTransformRotationAngle];
    // 开始旋转
    [UIView commitAnimations];
}

- (CGAffineTransform)getTransformRotationAngle {
    // 状态条的方向已经设置过,所以这个就是你想要旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}

#pragma mark - setter

- (void)setIsFullScreen:(BOOL)isFullScreen {
    _isFullScreen = isFullScreen;
    [self.btnFullScreen setTitle:isFullScreen?@"退出全屏":@"全屏" forState:UIControlStateNormal];
}

#pragma mark - getter

- (UIView *)playerView {
    if (!_playerView) {
        _playerView = [[UIView alloc]init];
        _playerView.backgroundColor = [UIColor redColor];
        
        if (@available(iOS 11.0, *)) {
            _playerView.frame = CGRectMake(0, self.view.safeAreaInsets.top, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * 9 / 16.f);
        } else {
            _playerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * 9 / 16.f);
        }
        
    }
    return _playerView;
}

- (UIButton *)btnFullScreen {
    if (!_btnFullScreen) {
        _btnFullScreen = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnFullScreen setTitle:@"全屏" forState:UIControlStateNormal];
        _btnFullScreen.backgroundColor = [UIColor orangeColor];
        [_btnFullScreen addTarget:self action:@selector(fullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnFullScreen.frame = CGRectMake(50, 80, 150, 50);
    }
    return _btnFullScreen;
}

@end
