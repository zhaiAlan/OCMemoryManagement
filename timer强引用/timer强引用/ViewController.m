//
//  ViewController.m
//  timer强引用
//
//  Created by Alan on 3/25/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (IBAction)next:(id)sender {
    [self.navigationController pushViewController:[FirstViewController alloc] animated:YES];
}


@end
