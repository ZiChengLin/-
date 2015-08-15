//
//  ContentCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/17.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ContentTitleCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation ContentTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    
    self.cardTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, WIDTH-40, 40)];
    _cardTitleLabel.backgroundColor = [UIColor orangeColor];
    _cardTitleLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_cardTitleLabel];
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
