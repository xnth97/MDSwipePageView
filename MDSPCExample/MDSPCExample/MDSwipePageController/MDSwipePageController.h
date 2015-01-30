//
//  MDSwipePageController.h
//
//  Created by Qin Yubo on 15/1/26.
//  Copyright (c) 2015年 Qin Yubo. All rights reserved.
//
//  Inspired by RKSwipeBetweenViewControllers, Richard Kim
//

#import <UIKit/UIKit.h>

@protocol MDSwipePageControllerDelegate <NSObject>

@end

@interface MDSwipePageController : UINavigationController <UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *viewControllerArray;
@property (nonatomic, weak) id<MDSwipePageControllerDelegate> navDelegate;
@property (nonatomic, strong) UIView *selectionBar;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) NSArray *buttonTitles;
@property (strong, nonatomic) UIColor *backgroundTintColor;

@end
