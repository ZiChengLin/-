//
//  LikeZeroViewCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/21.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "LikeZeroViewCell.h"
#import "CardTypeModel.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation LikeZeroViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {

    self.cardTypeTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, WIDTH-40, 20)];
    //_cardTypeTitle.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_cardTypeTitle];
    
    self.cardRemark = [[UILabel alloc] initWithFrame:CGRectMake(20, _cardTypeTitle.frame.origin.y + 25, WIDTH-40, HEIGHT/8-self.cardTypeTitle.frame.size.height - 15)];
    //_cardRemark.backgroundColor = [UIColor yellowColor];
    _cardRemark.font = [UIFont systemFontOfSize:12];
    _cardRemark.numberOfLines = 0;
    [self.contentView addSubview:_cardRemark];
    
    self.signName = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-80, 5, 60, 20)];
    _signName.font = [UIFont systemFontOfSize:13];
    _signName.textAlignment = NSTextAlignmentRight;
    //_signName.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_signName];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.isEditing) {
        
        [self sendSubviewToBack:self.contentView];
    }
}

- (void)setCardType:(CardTypeModel *)cardType {
    
    _cardType = cardType;
    _cardTypeTitle.text = cardType.cardTitle;
    _cardRemark.text = cardType.cardRemark;
    _signName.text = cardType.signName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
