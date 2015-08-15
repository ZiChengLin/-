//
//  ArticleCollectionCell.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/22.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCLabel.h"

@class DanduModel;
@interface ArticleCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *pictureView;
@property (nonatomic, strong) ZCLabel     *titleLabel;
@property (nonatomic, strong) UILabel     *updateTimeLabel;

@property (nonatomic, strong) DanduModel  *dandu;

@end
