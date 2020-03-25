//
//  ViewController.m
//  taggedPointer
//
//  Created by Alan on 3/24/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>

extern uintptr_t objc_debug_taggedpointer_obfuscator;

@interface ViewController ()

@property (nonatomic, strong) dispatch_queue_t  queue;
@property (nonatomic, strong) NSString *nameStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // alloc 出来的对象引用计数为1
    // 0
    // alloc 有没有 retainCount
    NSObject *objc = [NSObject alloc];
    NSLog(@"objc--->%ld",CFGetRetainCount((__bridge CFTypeRef)objc));
    
    // 地址
    // 地址简单的地址 : 地址+值
    // [self taggedPointerDemo];
    
//    [self taggentPointer];
    
}
- (void)taggentPointer
{
    // 优化 - 编译读取的时候 更直接
    // retian release
    // 3倍
    // 创建 100
    // [8-10]
    
    NSString *str1 = [NSString stringWithFormat:@"a"];
    NSString *str2 = [NSString stringWithFormat:@"ab"];
    NSString *str3 = [NSString stringWithFormat:@"abc"];
    NSString *str4 = [NSString stringWithFormat:@"abcd"];
    NSString *str5 = [NSString stringWithFormat:@"abcde"];
    NSString *str6 = [NSString stringWithFormat:@"abcdef"];

    NSLog(@"%@--%p-%@--0x%lx",object_getClass(str1),str1,str1,_objc_decodeTaggedPointer_(str1));
    NSLog(@"%@--%p-%@--0x%lx",object_getClass(str2),str2,str2,_objc_decodeTaggedPointer_(str2));
    NSLog(@"%@--%p-%@--0x%lx",object_getClass(str3),str3,str3,_objc_decodeTaggedPointer_(str3));
    NSLog(@"%@--%p-%@--0x%lx",object_getClass(str4),str4,str4,_objc_decodeTaggedPointer_(str4));
    NSLog(@"%@--%p-%@--0x%lx",object_getClass(str5),str5,str5,_objc_decodeTaggedPointer_(str5));
    NSLog(@"%@--%p-%@--0x%lx",object_getClass(str6),str6,str6,_objc_decodeTaggedPointer_(str6));
//    NSLog(@"0x%lx",_objc_decodeTaggedPointer_(str1));
//    NSLog(@"0x%lx",_objc_decodeTaggedPointer_(str2));

    NSNumber *number1 = @1;
    NSNumber *number2 = @1;
    NSNumber *number3 = @2.0;
    NSNumber *number4 = @3.2;
//    NSLog(@"%@--%p---%@",object_getClass(number1),number1,number1);
//    NSLog(@"%@--%p---%@",object_getClass(number2),number2,number2);
//    NSLog(@"%@--%p---%@",object_getClass(number3),number3,number3);
//    NSLog(@"%@--%p---%@",object_getClass(number4),number4,number4);
    
    NSLog(@"%@-%p-%@ - 0x%lx",object_getClass(number1),number1,number1,_objc_decodeTaggedPointer_(number1));
    NSLog(@"%@-%p-%@ - 0x%lx",object_getClass(number2),number2,number2,_objc_decodeTaggedPointer_(number2));
    NSLog(@"%@-%p-%@ - 0x%lx",object_getClass(number3),number3,number3,_objc_decodeTaggedPointer_(number3));
    NSLog(@"%@-%p-%@ - 0x%lx",object_getClass(number4),number4,number4,_objc_decodeTaggedPointer_(number4));
    
}
uintptr_t
_objc_decodeTaggedPointer_(id ptr)
{
    return (uintptr_t)ptr ^ objc_debug_taggedpointer_obfuscator;
}

//MARK: - taggedPointer 面试题
- (void)taggedPointerDemo {
    
    // 多线程
    // setter getter
    /**
     retian newvalue
     realase oldvalue
     taggedpointer 影响
     */

    self.queue = dispatch_queue_create("com.cooci.cn", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i<10000; i++) {
        dispatch_async(self.queue, ^{
            self.nameStr = [NSString stringWithFormat:@"alanalanala"];
            NSLog(@"%@",self.nameStr);
        });
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"来了");
    for (int i = 0; i<10000; i++) {
        dispatch_async(self.queue, ^{
            self.nameStr = [NSString stringWithFormat:@"内存管理--内存管理方案"];
            NSLog(@"%@",self.nameStr);
        });
    }

}


@end
