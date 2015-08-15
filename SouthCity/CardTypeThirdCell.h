//
//  CardTypeThirdCell.h
//  SouthCity
//
//  Created by 林梓成 on 15/8/12.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCLabel.h"

@class CardTypeModel;
@interface CardTypeThirdCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgCellView;

@property (nonatomic, strong) UIButton    *authorNameBtn;
@property (nonatomic, strong) UILabel     *cardTitleLabel;
@property (nonatomic, strong) ZCLabel     *cardRemarkLabel;

@property (nonatomic, strong) CardTypeModel *zero;

+ (CGFloat)cellContentHeight:(CardTypeModel *)content;

@end
