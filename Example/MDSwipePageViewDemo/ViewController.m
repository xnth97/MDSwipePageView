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
    pageView.titleHeight = 42;
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setFrame:CGRectMake(40, 60, 100, 30)];
        [btn setTitle:@"BUTTON" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnTapped) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor whiteColor];
    [view2 addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setFrame:CGRectMake(40, 160, 100, 30)];
        [btn setTitle:@"BUTTON" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnTapped) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
    
    pageView.subPageViews = @[view1, view2];
    pageView.titlesForSubPageViews = @[@"view1", @"view2"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)btnTapped {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"View Controller";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
