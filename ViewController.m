//
//  ViewController.m
//  HeartEmitter
//
//  Created by FFFF on 16/9/2.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import "ViewController.h"
#import "HeartEmitter.h"

@interface ViewController ()
@property (nonatomic,weak) UIButton *likeBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(300, 500, 50, 50)];
    [likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateHighlighted];
    [likeBtn addTarget:self action:@selector(heardEmitter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeBtn];
}
- (void)heardEmitter{
    
    [[HeartEmitter defaultEmitter] startFireWithView:self.view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
