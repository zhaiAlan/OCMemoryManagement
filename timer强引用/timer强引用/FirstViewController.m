//
//  FirstViewController.m
//  timer强引用
//
//  Created by Alan on 3/25/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "FirstViewController.h"
#import <objc/runtime.h>
#import "XZTimerWapper.h"
#import "XZProxy.h"
static int num = 0;

@interface FirstViewController ()
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) XZTimerWapper *timerWapper;
@property (nonatomic, strong) id            target;
@property (nonatomic, strong) XZProxy       *proxy;

@end

@implementation FirstViewController

void fireHomeFunc(){
    NSLog(@"%s",__func__);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
        // self -> timer -> self
        // 这里用 weakSelf 能够解决!!!
        NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)self));

        // self -> timer -weakSelf-> self
        __weak typeof(self) weakSelf = self; // weak
        // self.timer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(fireHome) userInfo:nil repeats:YES];
        // 加runloop
        // [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        // runloop -> timer -> self
        // self -> timer -> self
       
        NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)self));

        // 两个同时持有 - 引用计数没有处理
        
        // 对象的地址
        // self 的地址 和 weakSelf 的地址不一样!!!!
        // self -> block -> weakSelf (临时变量的指针地址)
        // weakSelf 能够释放
        // 强持有 - 对象
        // NSRunLoop -> timer -> weakSelf -> self
        
    //     self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(fireHome) userInfo:nil repeats:YES];

        // 解决思路 : 我们需要打破这一层强持有
        
        // 思路一: dealloc 不能来 那我们能不能看看有没有其他的方法在pop的时候 就销毁timer
        // 把 核心timer 销毁 那么 强持有 - 循环引用就不存在
        
        // 思路二: 中介者模式 - 不方便使用 self
        // 换其他对象
    //     self.target = [[NSObject alloc] init];
    //     class_addMethod([NSObject class], @selector(fireHome), (IMP)fireHomeObjc, "v@:");
    //     self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.target selector:@selector(fireHome) userInfo:nil repeats:YES];
        
        // 思路三: 感觉 NSObject 这里写在这里好恶心! 裹脚布藏起来
        // self.timerWapper = [[LGTimerWapper alloc] lg_initWithTimeInterval:1 target:self selector:@selector(fireHome) userInfo:nil repeats:YES];
        
        // 思路四: proxy 虚基类的方式
        self.proxy = [XZProxy proxyWithTransformObject:self];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.proxy selector:@selector(fireHome) userInfo:nil repeats:YES];




    // Do any additional setup after loading the view.
}

//- (void)didMoveToParentViewController:(UIViewController *)parent{
//    // 无论push 进来 还是 pop 出去 正常跑
//    // 就算继续push 到下一层 pop 回去还是继续
//    if (parent == nil) {
//       [self.timer invalidate];
//        self.timer = nil;
//        NSLog(@"timer 走了");
//    }
//}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    // push 到下一层返回就不走了!!!
//    [self.timer invalidate];
//    self.timer = nil;
//    NSLog(@"timer 走了");
//}

void fireHomeObjc(id obj){
    NSLog(@"%s -- %@",__func__,obj);
}

- (void)fireHome{
    num++;
    NSLog(@"hello word - %d",num);
}

- (void)dealloc{
    // [self.timerWapper lg_invalidate];

    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"%s",__func__);
}

- (void)blockTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer fire - %@",timer);
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
