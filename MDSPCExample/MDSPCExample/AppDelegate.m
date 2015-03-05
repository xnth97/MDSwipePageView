//
//  AppDelegate.m
//  MDSPCExample
//
//  Created by 秦昱博 on 15/1/30.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

#import "AppDelegate.h"
#import "MDSwipePageController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    MDSwipePageController *mdSwipeController = [[MDSwipePageController alloc]initWithRootViewController:pageController];
    
    UIViewController *demo1 = [[UIViewController alloc]init];
    UIViewController *demo2 = [[UIViewController alloc]init];
    UIViewController *demo3 = [[UIViewController alloc]init];
    UIViewController *demo4 = [[UIViewController alloc]init];
    demo1.view.backgroundColor = [UIColor whiteColor];
    demo2.view.backgroundColor = [UIColor greenColor];
    demo3.view.backgroundColor = [UIColor redColor];
    demo4.view.backgroundColor = [UIColor orangeColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, demo1.view.frame.size.width, demo1.view.frame.size.height - 94)];
    [demo1.view addSubview:tableView];
    
    [mdSwipeController.viewControllerArray addObjectsFromArray:@[demo1, demo2, demo3, demo4]];
    mdSwipeController.buttonTitles = @[@"title", @"title", @"title", @"title"];
    mdSwipeController.backgroundTintColor = [UIColor colorWithRed:0/255.0f green:138/255.0f blue:244/255.0f alpha:1.0f];
    mdSwipeController.title = @"Title";
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [leftBtn addTarget:self action:@selector(testFunc) forControlEvents:UIControlEventTouchUpInside];
    mdSwipeController.leftBarButton = leftBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [rightBtn addTarget:self action:@selector(testFunc) forControlEvents:UIControlEventTouchUpInside];
    mdSwipeController.rightBarButton = rightBtn;
    
    self.window.rootViewController = mdSwipeController;

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)testFunc {
    NSLog(@"test");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
