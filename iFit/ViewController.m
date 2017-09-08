//
//  ViewController.m
//  iFit
//
//  Created by 区振轩 on 2017/9/8.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(90, 90, 90, 90)];
    view.backgroundColor  = [UIColor redColor];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
