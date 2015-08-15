//
//  DEMONavigationController.m
//  REFrostedViewControllerExample
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015 Lin. All rights reserved.
//

#import "NavigationController.h"
#import "MenuViewController.h"
#import "UIViewController+REFrostedViewController.h"

@interface NavigationController ()

@property (strong, readwrite, nonatomic) MenuViewController *menuViewController;

@end

@implementation NavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    
    [self.frostedViewController panGestureRecognized:sender];
}

@end
