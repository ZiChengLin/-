//
//  REFrostedViewController.h
//  REFrostedViewController
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+REFrostedViewController.h"

typedef NS_ENUM(NSInteger, REFrostedViewControllerDirection) {
    REFrostedViewControllerDirectionLeft,
    REFrostedViewControllerDirectionRight,
    REFrostedViewControllerDirectionTop,
    REFrostedViewControllerDirectionBottom
};

typedef NS_ENUM(NSInteger, REFrostedViewControllerLiveBackgroundStyle) {
    REFrostedViewControllerLiveBackgroundStyleLight,
    REFrostedViewControllerLiveBackgroundStyleDark
};

@interface REFrostedViewController : UIViewController

@property (assign, readwrite, nonatomic) REFrostedViewControllerDirection direction;
@property (strong, readwrite, nonatomic) UIColor *blurTintColor;
@property (assign, readwrite, nonatomic) CGFloat blurRadius; // Used only when live blur is off
@property (assign, readwrite, nonatomic) CGFloat blurSaturationDeltaFactor; // Used only when live blur is off
@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (assign, readwrite, nonatomic) BOOL limitMenuViewSize;
@property (assign, readwrite, nonatomic) CGSize minimumMenuViewSize;
@property (assign, readwrite, nonatomic) BOOL liveBlur;
@property (assign, readwrite, nonatomic) REFrostedViewControllerLiveBackgroundStyle liveBlurBackgroundStyle;

@property (strong, readwrite, nonatomic) UIViewController *contentViewController;
@property (strong, readwrite, nonatomic) UIViewController *menuViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController menuViewController:(UIViewController *)menuViewController;
- (void)presentMenuViewController;
- (void)hideMenuViewController;
- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;

@end
