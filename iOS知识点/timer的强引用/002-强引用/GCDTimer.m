//
//  GCDTimer.m
//  002-强引用
//
//  Created by sn on 2019/11/21.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "GCDTimer.h"

@interface GCDTimer ()
@property (nonatomic, assign) BOOL done;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation GCDTimer
+ (GCDTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    GCDTimer *Timer = GCDTimer.alloc.init;
    
    //创建定时器，并指定线程，dispatch_source_t 本质上也是一个OC对象；
    Timer.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    //设置定时器间隔时间
    dispatch_source_set_timer(Timer.timer, DISPATCH_TIME_NOW, (uint64_t)(1.0 * NSEC_PER_SEC), 0);
    
    //设置定时器 action
    dispatch_source_set_event_handler(Timer.timer, ^{
        if (yesOrNo || !Timer.done) {
            if (aTarget && [aTarget respondsToSelector:aSelector]) {
                [aTarget performSelector:aSelector withObject:userInfo];
                Timer.done = YES;
            }
        }
    });
    dispatch_resume(Timer.timer);  //启动定时器
    
    return Timer;
}

- (void)invalidate {
    dispatch_source_cancel(_timer);
    dispatch_cancel(_timer);
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    
    dispatch_source_cancel(_timer);
    dispatch_cancel(_timer);
    _timer = nil;
}
@end
