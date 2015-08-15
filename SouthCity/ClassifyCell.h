//
//  ClassifyCell.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClassifyModel;
@interface ClassifyCell : UICollectionViewCell

@property (nonatomic, strong) UIView      *view;
@property (nonatomic, strong) UIImageView *bgPictureImageView;
@property (nonatomic, strong) UILabel     *titleLabel;

@property (nonatomic, strong) ClassifyModel *classify;

@end
