//
//  ZeroSignTypeThirdCell.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/17.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCLabel.h"

@class SignTypeModel;
@interface ZeroSignTypeThirdCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgCellView;

@property (nonatomic, strong) UIButton    *authorNameBtn;
@property (nonatomic, strong) UIButton    *signBtn;
@property (nonatomic, strong) UILabel     *cardTitleLabel;
@property (nonatomic, strong) ZCLabel     *cardRemarkLabel;

@property (nonatomic, strong) SignTypeModel *zero;

+ (CGFloat)cellContentHeight:(SignTypeModel *)content;

@end
