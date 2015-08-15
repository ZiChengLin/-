//
//  ContentViewController.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/16.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardTypeModel;
@interface ContentViewController : UIViewController

@property (nonatomic, strong) NSString *urlId;
@property (nonatomic, strong) NSString *cardTitleStr;
@property (nonatomic, strong) NSString *signNameStr;

@property (nonatomic, strong) NSString *cardRemarkStr;
@property (nonatomic, strong) NSString *pictureStr;

@property (nonatomic, strong) CardTypeModel *contentModel;

@end
