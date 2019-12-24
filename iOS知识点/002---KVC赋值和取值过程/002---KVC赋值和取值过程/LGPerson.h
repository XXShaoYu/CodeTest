//
//  LGPerson.h
//  002---KVC赋值过程
//
//  Created by cooci on 2018/12/18.
//  Copyright © 2018 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject{
    @public
    NSInteger a;
    NSString *_name; // cooci
//    NSString *_isName;// cooci
//    NSString *name; // null
//    NSString *isName;
}

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, assign) BOOL open;

@end

NS_ASSUME_NONNULL_END
