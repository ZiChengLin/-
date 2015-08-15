//
//  UIViewController+REFrostedViewController.h
//  REFrostedViewController
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class REFrostedViewController;

@interface UIViewController (REFrostedViewController)

@property (strong, readonly, nonatomic) REFrostedViewController *frostedViewController;

- (void)re_displayController:(UIViewController *)controller frame:(CGRect)frame;
- (void)re_hideController:(UIViewController *)controller;

@end
