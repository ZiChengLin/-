//
//  LikeZeroViewCell.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/21.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardTypeModel;
@interface LikeZeroViewCell : UITableViewCell

@property (nonatomic, strong) UILabel     *cardTypeTitle;
@property (nonatomic, strong) UILabel     *cardRemark;
@property (nonatomic, strong) UILabel     *signName;

@property (nonatomic, strong) CardTypeModel *cardType;

@end
