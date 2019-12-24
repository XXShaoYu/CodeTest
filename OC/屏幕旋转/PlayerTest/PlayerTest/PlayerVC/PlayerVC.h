//
//  PlayerVC.h
//  PlayerTest
//
//  Created by sn on 2019/12/24.
//  Copyright © 2019 sn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PlayerVC;
@protocol PlayerVCDelegate <NSObject>
- (void)fullScreenClickWithPlayerVC:(PlayerVC *)vc;
@end

@interface PlayerVC : UIViewController
@property (nonatomic, weak) id<PlayerVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
