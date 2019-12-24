//
//  PlayerVC.m
//  PlayerTest
//
//  Created by sn on 2019/12/24.
//  Copyright © 2019 sn. All rights reserved.
//

#import "PlayerVC.h"

@interface PlayerVC ()

@end

@implementation PlayerVC

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
}

- (IBAction)fullScreenBtnClick {
    if (_delegate && [_delegate respondsToSelector:@selector(fullScreenClickWithPlayerVC:)]) {
        [_delegate fullScreenClickWithPlayerVC:self];
    }
}

@end
