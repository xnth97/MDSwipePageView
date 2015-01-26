//
//  MDSwipePageController.m
//
//  Created by 秦昱博 on 15/1/26.
//  Copyright (c) 2015年 Richard Kim. All rights reserved.
//
//  Inspired by RKSwipeBetweenViewControllers, Richard Kim
//

#import "MDSwipePageController.h"

//%%% customizeable button attributes
#define X_BUFFER 0 //%%% the number of pixels on either side of the segment
#define Y_BUFFER 60 //%%% number of pixels on top of the segment
#define HEIGHT 34 //%%% height of the segment

//%%% customizeable selector bar attributes (the black bar under the buttons)
#define ANIMATION_SPEED 0.2 //%%% the number of seconds it takes to complete the animation
#define SELECTOR_HEIGHT 4 //%%% thickness of the selector bar
#define BUTTON_FONT_SIZE 13.0

#define X_OFFSET 0 //%%% for some reason there's a little bit of a glitchy offset.  I'm going to look for a better workaround in the future

#define TINT_COLOR backgroundTintColor

@interface MDSwipePageController () {
    UIScrollView *pageScrollView;
    NSInteger currentPageIndex;
}

@end

@implementation MDSwipePageController

@synthesize viewControllerArray;
@synthesize selectionBar;
@synthesize panGestureRecognizer;
@synthesize pageController;
@synthesize navigationView;
@synthesize buttonText;
@synthesize backgroundTintColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarHidden = YES;
    
    viewControllerArray = [[NSMutableArray alloc]init];
    currentPageIndex = 0;
    
    if (backgroundTintColor == nil) {
        backgroundTintColor = [UIColor lightGrayColor];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupSegmentButtons
{
    navigationView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,self.navigationBar.frame.size.height + HEIGHT)];
    navigationView.backgroundColor = TINT_COLOR;
    navigationView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    navigationView.layer.shadowOffset = CGSizeMake(0, 3.0);
    navigationView.layer.shadowOpacity = 0.3;
    navigationView.layer.shadowRadius = 5.0;
    
    NSInteger numControllers = [viewControllerArray count];
    
    // 设置标题
    if (!buttonText) {
        buttonText = [[NSArray alloc]initWithObjects: @"first",@"second",@"third",@"etc",@"etc",@"etc",@"etc",nil];
    }
    
    for (int i = 0; i<numControllers; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(X_BUFFER+i*(self.view.frame.size.width-2*X_BUFFER)/numControllers-X_OFFSET, Y_BUFFER, (self.view.frame.size.width-2*X_BUFFER)/numControllers, HEIGHT)];
        
        [navigationView addSubview:button];
        
        button.tag = i;
        button.backgroundColor = TINT_COLOR;
        
        [button setTitle:[buttonText objectAtIndex:i] forState:UIControlStateNormal]; //%%%buttontitle
        // 按钮字号
        [button.titleLabel setFont:[UIFont systemFontOfSize:BUTTON_FONT_SIZE]];
        [button addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [pageController.view addSubview:navigationView];
    
    [self setupSelector];
}


// sets up the selection bar under the buttons on the navigation bar
- (void)setupSelector {
    selectionBar = [[UIView alloc]initWithFrame:CGRectMake(X_BUFFER-X_OFFSET, Y_BUFFER+HEIGHT-SELECTOR_HEIGHT,(self.view.frame.size.width-2*X_BUFFER)/[viewControllerArray count], SELECTOR_HEIGHT)];
    selectionBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [navigationView addSubview:selectionBar];
}

// Generally, this shouldn't be changed unless you know what you're changing.

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupPageViewController];
    [self setupSegmentButtons];
}

//%%% generic setup stuff for a pageview controller.  Sets up the scrolling style and delegate for the controller
- (void)setupPageViewController {
    pageController = (UIPageViewController *)self.topViewController;
    pageController.delegate = self;
    pageController.dataSource = self;
    
    [pageController setViewControllers:@[[viewControllerArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    // Here the 20px bug solved!
    pageController.automaticallyAdjustsScrollViewInsets = NO;
    for (UIViewController *childController in pageController.childViewControllers) {
        childController.view.frame = CGRectMake(0, Y_BUFFER + HEIGHT, self.view.frame.size.width, self.view.frame.size.height - Y_BUFFER - HEIGHT);
    }
    pageController.view.backgroundColor = [UIColor whiteColor];
    [self syncScrollView];
}

//%%% this allows us to get information back from the scrollview, namely the coordinate information that we can link to the selection bar.
- (void)syncScrollView {
    for (UIView* view in pageController.view.subviews){
        if([view isKindOfClass:[UIScrollView class]]) {
            pageScrollView = (UIScrollView *)view;
            pageScrollView.delegate = self;
        }
    }
}

//%%% methods called when you tap a button or scroll through the pages
// generally shouldn't touch this unless you know what you're doing or
// have a particular performance thing in mind

//%%% when you tap one of the buttons, it shows that page,
//but it also has to animate the other pages to make it feel like you're crossing a 2d expansion,
//so there's a loop that shows every view controller in the array up to the one you selected
//eg: if you're on page 1 and you click tab 3, then it shows you page 2 and then page 3
-(void)tapSegmentButtonAction:(UIButton *)button
{
    NSInteger tempIndex = currentPageIndex;
    
    __weak typeof(self) weakSelf = self;
    
    //%%% check to see if you're going left -> right or right -> left
    if (button.tag > tempIndex) {
        
        //%%% scroll through all the objects between the two points
        for (int i = (int)tempIndex+1; i<=button.tag; i++) {
            [pageController setViewControllers:@[[viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL complete){
                
                //%%% if the action finishes scrolling (i.e. the user doesn't stop it in the middle),
                //then it updates the page that it's currently on
                if (complete) {
                    [weakSelf updateCurrentPageIndex:i];
                }
            }];
        }
    }
    
    //%%% this is the same thing but for going right -> left
    else if (button.tag < tempIndex) {
        for (int i = (int)tempIndex-1; i >= button.tag; i--) {
            [pageController setViewControllers:@[[viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL complete){
                if (complete) {
                    [weakSelf updateCurrentPageIndex:i];
                }
            }];
        }
    }
}

//%%% makes sure the nav bar is always aware of what page you're on
//in reference to the array of view controllers you gave
-(void)updateCurrentPageIndex:(int)newIndex {
    currentPageIndex = newIndex;
}

//%%% method is called when any of the pages moves.
//It extracts the xcoordinate from the center point and instructs the selection bar to move accordingly
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat xFromCenter = self.view.frame.size.width - pageScrollView.contentOffset.x; //%%% positive for right swipe, negative for left
    
    //%%% checks to see what page you are on and adjusts the xCoor accordingly.
    //i.e. if you're on the second page, it makes sure that the bar starts from the frame.origin.x of the
    //second tab instead of the beginning
    NSInteger xCoor = X_BUFFER + selectionBar.frame.size.width * currentPageIndex;
    
    selectionBar.frame = CGRectMake(xCoor - xFromCenter/[viewControllerArray count], selectionBar.frame.origin.y, selectionBar.frame.size.width, selectionBar.frame.size.height);
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfController:viewController];
    
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    
    index--;
    return [viewControllerArray objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [viewControllerArray count]) {
        return nil;
    }
    return [viewControllerArray objectAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        currentPageIndex = [self indexOfController:[pageViewController.viewControllers lastObject]];
    }
}


//%%% checks to see which item we are currently looking at from the array of view controllers.
// not really a delegate method, but is used in all the delegate methods, so might as well include it here
- (NSInteger)indexOfController:(UIViewController *)viewController {
    for (int i = 0; i < [viewControllerArray count]; i++) {
        if (viewController == [viewControllerArray objectAtIndex:i]) {
            return i;
        }
    }
    return NSNotFound;
}


@end
