//
//  ArticleCollectionCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/22.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ArticleCollectionCell.h"
#import "DanduModel.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation ArticleCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2-1, WIDTH/2-1-40)];
        //_pictureView.backgroundColor = [UIColor brownColor];
        [self.contentView addSubview:_pictureView];
        
        self.titleLabel = [[ZCLabel alloc] initWithFrame:CGRectMake(0, self.pictureView.frame.size.height, WIDTH/2-1, 40)];
        //_titleLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.numberOfLines = 0;
        [_titleLabel setVerticalAlignment:VerticalAlignmentTop];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setDandu:(DanduModel *)dandu {
    
    _dandu = dandu;
    _titleLabel.text = dandu.title;
    _updateTimeLabel.text = dandu.updateTime;
}


@end
