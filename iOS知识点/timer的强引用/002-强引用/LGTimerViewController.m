//
//  LGTimerViewController.m
//  003---强引用问题
//
//  Created by cooci on 2019/1/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGTimerViewController.h"
#import "LGTimerWapper.h"
#import "LGProxy.h"
#import "OtherTargert.h"
#import "GCDTimer.h"

static int num = 0;

typedef NS_ENUM(NSInteger, TimerMoveType) {
    TimerDidMoveToNil = 0,      // ✔️
    TimerMoveWithWapper,        // ✔️
    TimerMoveOtherTarget,       // ✔️
    TimerMoveProxy,             // ✔️  最方便
    TimerMoveBlock,             // ✔️  方便，但是要注意系统版本 iOS10.0之后
    TimerMoveGCDTimer,          // ✔️  对于打破强引用来说，其实并不方便
    TimerMoveWeakTimer,         // ❌
    TimerMoveWeakSelfDelegate,  // ❌
};


@interface LGTimerViewController ()
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) LGTimerWapper *timerWapper;
@property (nonatomic, strong) OtherTargert  *target;
@property (nonatomic, strong) LGProxy       *proxy;
@property (nonatomic, assign) TimerMoveType timerType;
@property (nonatomic, weak) NSTimer         *weakTimer;     //  没有用，详情见mark
@property (nonatomic, strong) GCDTimer *gcdTimer;
@end

@implementation LGTimerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerType = TimerDidMoveToNil;
    
    
    if (_timerType == TimerDidMoveToNil) {
        [self timerDidMoveToNil];
    } else if (_timerType == TimerMoveWithWapper) {
        [self timerMoveWithWapper];
    } else if (_timerType == TimerMoveOtherTarget) {
        [self timerMoveOtherTarget];
    } else if (_timerType == TimerMoveProxy) {
        [self timerMoveProxy];
    } else if (_timerType == TimerMoveBlock) {
        [self timerMoveBlock];
    } else if (_timerType == TimerMoveGCDTimer) {
        [self timerMoveGCDTimer];
    } else if (_timerType == TimerMoveWeakTimer) {
        [self timerMoveWeakTimer];
    } else if (_timerType == TimerMoveWeakSelfDelegate) {
        [self timerMoveWeakSelfDelegate];
    }
}

#pragma mark - timerDidMoveToNil
- (void)timerDidMoveToNil {
    // runloop -> timer -> target -> self
    // 这里没有循环引用 但是就是释放不了 因为强引用
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireHome) userInfo:@2 repeats:YES];
    
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    if (parent == nil) {
        if (_timerType == TimerDidMoveToNil) {
            [self.timer invalidate];
            self.timer = nil;
        } else if (_timerType == TimerMoveGCDTimer) {
            [self.gcdTimer invalidate];
        }
    }
}

#pragma mark - TimerMoveWithWapper
- (void)timerMoveWithWapper {
    // 移交强引用
    // self -> timerWapper -><- timer
    self.timerWapper = [[LGTimerWapper alloc] lg_initWithTimeInterval:1 target:self selector:@selector(fireHome) userInfo:nil repeats:YES];
}

#pragma mark - TimerMoveOtherTarget
- (void)timerMoveOtherTarget {
    // runtime移交
    // self -> self.target
    // self -> timer
    // timer -> self.target
    self.target = [[OtherTargert alloc] initWithVC:self];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.target selector:@selector(fireHome) userInfo:nil repeats:YES];
}

#pragma mark - TimerMoveProxy
- (void)timerMoveProxy{
    // proxy 移交消息转发
    self.proxy = [LGProxy proxyWithTransformObject:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.proxy selector:@selector(fireHome) userInfo:nil repeats:YES];
}

#pragma mark - TimerMoveBlock
- (void)timerMoveBlock{
    // 这种block 的方式得到过优化，不会引起强引用target(没有target的存在了)。但是注意block中如果使用 self，请注意循环引用
    // self -> timer -> block
    __weak typeof(self)weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf fireHome:nil];
    }];
}

#pragma mark - TimerMoveGCDTimer
- (void)timerMoveGCDTimer {
    // 也需要在合适的地方 invalidate ，
    // 也就是调用 dispatch_source_cancel(_timer);  dispatch_cancel(_timer);
    self.gcdTimer = [GCDTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireHome:) userInfo:@1 repeats:YES];
}

#pragma mark - TimerMoveWeakTimer 这种方式没用
// 这种方式并没有用
// 因为timer引起内存泄露的问题不是简单的循环引用而是因为timer要想起作用必须加到 runloop 中，runloop不会释放，timer也不会释放，timer.tagert 也就是self 不释放。所以解决的要点在于打破runloop，self，target。简简单单的打破 self和weak没用。
// runloop -> timer -> target -> self        self -> timer
- (void)timerMoveWeakTimer {
    self.weakTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireHome) userInfo:nil repeats:YES];
}

#pragma mark - TimerMoveWeakSelfDelegate
// 没用，估计 timer 对 target 是一个强引用
- (void)timerMoveWeakSelfDelegate {
    __weak typeof(self)weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(fireHome) userInfo:nil repeats:YES];
}


- (void)fireHome {
    [self fireHome:nil];
}

- (void)fireHome:(id)userInfo {
    num++;
    NSLog(@"hello word - %d",num);
}

- (void)dealloc{
    NSLog(@"%s",__func__);
    
    if (_timerType == TimerMoveWithWapper) {
        [self.timerWapper lg_invalidate];
    } else if (_timerType != TimerDidMoveToNil) {
        [self.timer invalidate];
        self.timer = nil;
    } else if (_timerType == TimerMoveWeakTimer) {
        [self.weakTimer invalidate];
        self.weakTimer = nil;
    }
}

@end
