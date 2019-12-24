//
//  AnimatedTrans.h
//  PlayerTest
//
//  Created by sn on 2019/12/23.
//  Copyright © 2019 sn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AnimatedTransType) {
    AnimatedTransToFullScreen,
    AnimatedTransMissFullScreen,
};

@interface AnimatedTrans : NSObject <UIViewControllerTransitioningDelegate>
+ (instancetype)transAnimationWithType:(AnimatedTransType)type fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame;
@end

NS_ASSUME_NONNULL_END
