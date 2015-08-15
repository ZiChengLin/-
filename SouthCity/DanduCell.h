//
//  DanduCell.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DanduModel;
@interface DanduCell : UITableViewCell

@property (nonatomic, strong) UIImageView *pictureView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *updateTimeLabel;

@property (nonatomic, strong) DanduModel  *dandu;

@end
