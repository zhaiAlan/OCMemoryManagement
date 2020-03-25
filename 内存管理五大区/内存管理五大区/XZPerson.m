//
//  XZPerson.m
//  内存管理五大区
//
//  Created by Alan on 3/24/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "XZPerson.h"

@implementation XZPerson
- (void)run{
    personNum ++;
    NSLog(@"XZPerson内部:%@-%p--%d",self,&personNum,personNum);
}

+ (void)eat{
    personNum ++;
    NSLog(@"XZPerson内部:%@-%p--%d",self,&personNum,personNum);
}

- (NSString *)description{
    return @"";
}
@end
