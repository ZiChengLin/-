//
//  SignTypeCell.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/17.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignTypeModel;
@interface SignTypeCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgCellView;

@property (nonatomic, strong) UIButton    *authorNameBtn;
@property (nonatomic, strong) UIButton    *signBtn;
@property (nonatomic, strong) UILabel     *cardTitleLabel;
@property (nonatomic, strong) UIImageView *cardTypeTwoImage;

@property (nonatomic, strong) SignTypeModel *sign;

+ (CGFloat)cellContentHeight:(SignTypeModel *)content;

@end
