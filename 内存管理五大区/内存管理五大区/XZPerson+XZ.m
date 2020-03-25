//
//  XZPerson+XZ.m
//  内存管理五大区
//
//  Created by Alan on 3/24/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "XZPerson+XZ.h"



@implementation XZPerson (XZ)
- (void)cate_method{
    NSLog(@"XZPerson内部:%@-%p--%d",self,&personNum,personNum);
}

@end
