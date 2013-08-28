//
//  ViewController.m
//  TWApp
//
//  Created by line0 on 13-7-6.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "TWViewController.h"

@interface TWViewController ()

@end

@implementation TWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [self.view setBackgroundColor:[UIColor orangeColor]];
}

- (UIView *)errorView
{
    return nil;
}

- (UIView *)loadingView
{
    return nil;
}

- (void)showLoadingAnimated:(BOOL) animated
{
    UIView *loadingView = [self loadingView];
    loadingView.alpha = 0.0f;
    [self.view addSubview:loadingView];
    [self.view bringSubviewToFront:loadingView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration
                     animations:^
     {
         loadingView.alpha = 1.0f;
     }];
}

- (void)hideLoadingViewAnimated:(BOOL) animated
{
    UIView *loadingView = [self loadingView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration
                     animations:^
     {
         loadingView.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         [loadingView removeFromSuperview];
     }];
}

- (void)showErrorViewAnimated:(BOOL) animated
{
    UIView *errorView = [self errorView];
    errorView.alpha = 0.0f;
    [self.view addSubview:errorView];
    [self.view bringSubviewToFront:errorView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration
                     animations:^
     {
         errorView.alpha = 1.0f;
     }];
}

- (void)hideErrorViewAnimated:(BOOL) animated
{
    UIView *errorView = [self errorView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^
     {
         errorView.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         [errorView removeFromSuperview];
     }]; 
}


@end
