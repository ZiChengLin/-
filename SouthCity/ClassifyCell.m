//
//  ClassifyCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ClassifyCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation ClassifyCell

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bgPictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2-1, WIDTH/2-1)];
        //_bgPictureImageView.backgroundColor = [UIColor brownColor];
        [self.contentView addSubview:_bgPictureImageView];
        
        /*
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH/2-1, WIDTH/2-1)];
        _view.backgroundColor = [UIColor blackColor];
        _view.alpha = 0.5;
        [self.contentView addSubview:_view];
        */
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (WIDTH/2-1)/2-15, WIDTH/2-1, 30)];
        //_titleLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel.text = @"#创意";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setClassify:(ClassifyModel *)classify {
    
    _classify = classify;
}

@end
