//
//  AppDelegate.m
//  MDSPCExample
//
//  Created by 秦昱博 on 15/1/30.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

#import "AppDelegate.h"
#import "MDSwipePageView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UIViewController *demo1 = [[UIViewController alloc]init];
    UIViewController *demo2 = [[UIViewController alloc]init];
    UIViewController *demo3 = [[UIViewController alloc]init];
    UIViewController *demo4 = [[UIViewController alloc]init];
    demo1.view.backgroundColor = [UIColor whiteColor];
    demo2.view.backgroundColor = [UIColor greenColor];
    demo3.view.backgroundColor = [UIColor blueColor];
    demo4.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController *mdSwipeController = [[UIViewController alloc] init];
    [mdSwipeController.view setFrame:[UIScreen mainScreen].bounds];
    MDSwipePageView *pageView = [[MDSwipePageView alloc] initWithFrame:mdSwipeController.view.frame];
    pageView.subPageViews = @[demo1.view, demo2.view, demo3.view, demo4.view];
    pageView.mainColor = [UIColor redColor];
    pageView.titlesForSubPageViews = @[@"View 1", @"View 2", @"View 3", @"View 4"];
    [mdSwipeController.view addSubview:pageView];
    
    self.window.rootViewController = mdSwipeController;

    [self.window makeKeyAndVisible];
    return YES;
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
