//
// REFrostedContainerViewController.h
// REFrostedViewController
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class REFrostedViewController;

@interface REFrostedContainerViewController : UIViewController

@property (strong, readwrite, nonatomic) UIImage *screenshotImage;
@property (weak, readwrite, nonatomic) REFrostedViewController *frostedViewController;
@property (assign, readwrite, nonatomic) BOOL animateApperance;

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;
- (void)hide;
- (void)refreshBackgroundImage;

@end
