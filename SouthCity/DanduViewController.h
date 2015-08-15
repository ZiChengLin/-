//
//  DanduViewController.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DanduModel;
@interface DanduViewController : UIViewController

@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *weburlString;
@property (nonatomic, strong) NSString *isHiddenString;  // 接受由收藏里面进入的是否隐藏字符串

@property (nonatomic, strong) DanduModel *dandu;

@end
