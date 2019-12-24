//
//  AnimatedTrans.m
//  PlayerTest
//
//  Created by sn on 2019/12/23.
//  Copyright © 2019 sn. All rights reserved.
//

#import "AnimatedTrans.h"

@interface AnimatedTrans ()
@property (nonatomic, assign) AnimatedTransType animationType;
@property (nonatomic, assign) CGRect fromFrame;
@property (nonatomic, assign) CGRect toFrame;
@end

@implementation AnimatedTrans
+ (instancetype)transAnimationWithType:(AnimatedTransType)type fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame {
    AnimatedTrans *animationTrans = AnimatedTrans.alloc.init;
    animationTrans.animationType = type;
    animationTrans.fromFrame = fromFrame;
    animationTrans.toFrame = toFrame;
    return animationTrans;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    NSTimeInterval anmationDuration = [self transitionDuration:transitionContext];
    
    if (_animationType == AnimatedTransToFullScreen) {
        toView.frame = _toFrame;
        [UIView animateWithDuration:anmationDuration animations:^{
            
        }];
    } else if (_animationType == AnimatedTransMissFullScreen) {
        
    }
}
@end
