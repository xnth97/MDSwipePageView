//
//  MDSwipePageView.m
//  MDSPCExample
//
//  Created by 秦昱博 on 15/6/12.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

#import "MDSwipePageView.h"

#define titleHeight 64
#define selectorHeight 4

@implementation MDSwipePageView {
    UIScrollView *mainScrollView;
    UIView *titleView;
    UIView *selectorView;
}

@synthesize mainColor;
@synthesize titlesForSubPageViews;
@synthesize subPageViews;
@synthesize delegate;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleHeight, self.frame.size.width, self.frame.size.height - titleHeight)];
    mainScrollView.contentSize = CGSizeMake(subPageViews.count * mainScrollView.frame.size.width, mainScrollView.frame.size.height);
    mainScrollView.pagingEnabled = YES;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.delegate = self;
    [self addSubview:mainScrollView];
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, titleHeight)];
    titleView.backgroundColor = mainColor;
    titleView.layer.shadowOffset = CGSizeMake(0, 2.0);
    titleView.layer.shadowOpacity = 0.3;
    titleView.layer.shadowRadius = 3.0;
    [self addSubview:titleView];
    
    for (int i = 0; i < subPageViews.count; i ++) {
        
        [mainScrollView addSubview:({
            UIView *tmpView = subPageViews[i];
            [tmpView setFrame:CGRectMake(i * mainScrollView.frame.size.width, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
            tmpView;
        })];
        
        [titleView addSubview:({
            UILabel *tmpLabel = [[UILabel alloc] init];
            [tmpLabel setFrame:CGRectMake(i * titleView.frame.size.width / subPageViews.count, 0, titleView.frame.size.width / subPageViews.count, titleView.frame.size.height)];
            tmpLabel.text = [titlesForSubPageViews[i] description];
            tmpLabel.textColor = [UIColor whiteColor];
            tmpLabel.font = [UIFont systemFontOfSize:14];
            tmpLabel.textAlignment = NSTextAlignmentCenter;
            tmpLabel.tag = i;
            tmpLabel.userInteractionEnabled = YES;
            [tmpLabel addGestureRecognizer:({
                UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recognizerTapped:)];
                tapRecognizer.numberOfTapsRequired = 1;
                tapRecognizer.delegate = self;
                tapRecognizer;
            })];
            tmpLabel;
        })];
    }
    
    selectorView = [[UIView alloc] initWithFrame:CGRectMake(0, titleHeight - selectorHeight, titleView.frame.size.width / subPageViews.count, selectorHeight)];
    selectorView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [titleView addSubview:selectorView];
    
}

- (void)recognizerTapped:(UITapGestureRecognizer *)sender {
    //NSLog(@"%ld tapped.", (long)sender.view.tag);
    [delegate pageWillChangeToIndex:sender.view.tag];
    [mainScrollView setContentOffset:CGPointMake(sender.view.tag * mainScrollView.frame.size.width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    float offSetX = offset.x;
    
    if (offSetX >= 0 && offSetX <= (subPageViews.count - 1) * mainScrollView.frame.size.width) {
        //NSLog(@"OffSetX = %f", offSetX);
        [selectorView setCenter:CGPointMake(offSetX / subPageViews.count + selectorView.frame.size.width / 2, selectorView.center.y)];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    float offSetX = offset.x;
    NSUInteger index = offSetX / mainScrollView.frame.size.width;
    [delegate pageChangedToIndex:index];
}


@end
