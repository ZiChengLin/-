//
//  DanduCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "DanduCell.h"
#import "DanduModel.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation DanduCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {

    self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, WIDTH-20, HEIGHT/3)];
    //_pictureView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_pictureView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.pictureView.frame.size.width-60, 10, 50, 20)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    [_pictureView addSubview:view];
    
    self.updateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    _updateTimeLabel.textColor = [UIColor whiteColor];
    _updateTimeLabel.textAlignment = NSTextAlignmentCenter;
    _updateTimeLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:_updateTimeLabel];
    
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.pictureView.frame.size.height + 20, WIDTH-20, 30)];
//    _titleLabel.backgroundColor = [UIColor yellowColor];
//    _titleLabel.font = [UIFont systemFontOfSize:16];
//    [self.contentView addSubview:_titleLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.pictureView.frame.size.height/2, WIDTH-20, 30)];
    //_titleLabel.backgroundColor = [UIColor yellowColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [_pictureView addSubview:_titleLabel];
}

- (void)setDandu:(DanduModel *)dandu {
    
    _dandu = dandu;
    _titleLabel.text = dandu.title;
    _updateTimeLabel.text = dandu.updateTime;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
