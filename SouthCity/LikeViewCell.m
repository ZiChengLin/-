//
//  LikeViewCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/20.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "LikeViewCell.h"
#import "CardTypeModel.h"
#import "UIImageView+WebCache.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation LikeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    
    self.likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, HEIGHT/6-10, HEIGHT/8-10)];
    //_likeImageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_likeImageView];
    
    //self.authorName = [[UILabel alloc] initWithFrame:CGRectMake(_likeImageView.frame.size.width + 40, 10, 100, 20)];
    //_authorName.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    //_authorName.backgroundColor = [UIColor redColor];
    //[self.contentView addSubview:_authorName];
    
    self.signName = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-80, 5, 60, 20)];
    _signName.font = [UIFont systemFontOfSize:13];
    _signName.textAlignment = NSTextAlignmentRight;
    //_signName.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_signName];
    
    self.cardTypeTitle = [[UILabel alloc] initWithFrame:CGRectMake(_likeImageView.frame.size.width + 40, _authorName.frame.origin.y + 20, WIDTH-_likeImageView.frame.size.width-60, HEIGHT/8-10-25)];
    //_cardTypeTitle.backgroundColor = [UIColor yellowColor];
    _cardTypeTitle.numberOfLines = 0;
    [self.contentView addSubview:_cardTypeTitle];
}

- (void)setCardType:(CardTypeModel *)cardType {
    
    _cardType = cardType;
    
    _cardTypeTitle.text = cardType.cardTitle;
    //_authorName.text = cardType.authorName;
    _signName.text = cardType.signName;
    
    [_likeImageView sd_setImageWithURL:[NSURL URLWithString:cardType.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
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
