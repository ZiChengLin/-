//
//  CardTypeTwoTwoCell.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/16.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardTypeModel;
@interface CardTypeTwoFourCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgCellView;

@property (nonatomic, strong) UIButton    *authorNameBtn;
@property (nonatomic, strong) UIButton    *signBtn;
@property (nonatomic, strong) UILabel     *cardTitleLabel;
@property (nonatomic, strong) UIImageView *cardTypeTwoImage;

@property (nonatomic, strong) CardTypeModel *two;

+ (CGFloat)cellContentHeight:(CardTypeModel *)content;

@end