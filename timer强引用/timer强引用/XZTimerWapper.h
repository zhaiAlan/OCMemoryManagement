//
//  XZTimerWapper.h
//  timer强引用
//
//  Created by Alan on 3/25/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZTimerWapper : NSObject
- (instancetype)xz_initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
- (void)xz_invalidate;

@end

NS_ASSUME_NONNULL_END
