//
//  XZPerson.h
//  内存管理五大区
//
//  Created by Alan on 3/24/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

static int personNum = 100;

NS_ASSUME_NONNULL_BEGIN

@interface XZPerson : NSObject
- (void)run;
+ (void)eat;

@end

NS_ASSUME_NONNULL_END
