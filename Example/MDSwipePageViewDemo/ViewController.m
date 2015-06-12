//
//  ViewController.m
//  MDSwipePageViewDemo
//
//  Created by 秦昱博 on 15/6/12.
//  Copyright (c) 2015年 Qin Yubo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize pageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Hello";
    
    pageView.mainColor = [UIColor colorWithRed:71/255.0f green:156/255.0f blue:27/255.0f alpha:1.0f];
    pageView.titleHeight = 46;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    pageView.subPageViews = @[view, view];
    pageView.titlesForSubPageViews = @[@"view1", @"view2"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
