//
//  LikeArticleCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/22.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "LikeArticleCell.h"
#import "DanduModel.h"
#import "UIImageView+WebCache.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation LikeArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    
    self.likeArticleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, HEIGHT/6-10, HEIGHT/8-10)];
    [self.contentView addSubview:_likeArticleImageView];
    
    self.articleTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_likeArticleImageView.frame.size.width + 40, 10, WIDTH-_likeArticleImageView.frame.size.width-60, HEIGHT/8-10-25)];
    
    _articleTitleLabel.numberOfLines = 0;
    [self.contentView addSubview:_articleTitleLabel];
}

- (void)setDandu:(DanduModel *)dandu {
    
    _dandu = dandu;
    _articleTitleLabel.text = dandu.title;
    
    [_likeArticleImageView sd_setImageWithURL:[NSURL URLWithString:dandu.url] placeholderImage:[UIImage imageNamed:@"missing_article"]];
}


// 编辑模式下 delete将多出来的label覆盖掉
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.isEditing) {
        
        [self sendSubviewToBack:self.contentView];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
