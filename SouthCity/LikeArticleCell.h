//
//  LikeArticleCell.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/22.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DanduModel;
@interface LikeArticleCell : UITableViewCell

@property (nonatomic, strong) UIImageView *likeArticleImageView;
@property (nonatomic, strong) UILabel     *articleTitleLabel;

@property (nonatomic, strong) DanduModel  *dandu;

@end
