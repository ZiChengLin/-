//
//  CardTypeThirdCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/8/12.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "CardTypeThirdCell.h"
#import "CardTypeModel.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation CardTypeThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    
    self.bgCellView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, WIDTH, 0)];
    _bgCellView.image = [UIImage imageNamed:@"cellbg"];
    [self.contentView addSubview:_bgCellView];
    
    self.authorNameBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _authorNameBtn.frame = CGRectMake(WIDTH-170, 10, 150, 20);
    //_authorNameBtn.backgroundColor = [UIColor orangeColor];
    _authorNameBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _authorNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;  // 设置按钮的内容进行左对齐
    [_authorNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_authorNameBtn];
    
    self.cardTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.authorNameBtn.frame.origin.y + 40, WIDTH-40, 0)];
    _cardTitleLabel.font = [UIFont systemFontOfSize:20];
    _cardTitleLabel.numberOfLines = 0;
    //_cardTitleLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_cardTitleLabel];
    
    self.cardRemarkLabel = [[ZCLabel alloc] initWithFrame:CGRectMake(20, 0, WIDTH-40, HEIGHT/6)];
    //_cardRemarkLabel.backgroundColor = [UIColor yellowColor];
    _cardRemarkLabel.font = [UIFont systemFontOfSize:14];
    [_cardRemarkLabel setVerticalAlignment:VerticalAlignmentTop];
    _cardRemarkLabel.numberOfLines = 0;
    [self.contentView addSubview:_cardRemarkLabel];
    
}

- (void)setZero:(CardTypeModel *)zero {
    
    _zero = zero;
    
    [_authorNameBtn setTitle:zero.authorName forState:UIControlStateNormal];
    

    _cardTitleLabel.text = zero.cardTitle;
    _cardRemarkLabel.text = zero.cardRemark;
    
    CGRect cardTitleRect = _cardTitleLabel.frame;
    cardTitleRect.size.height = [[self class] cellContentHeight:zero] - 45;
    _cardTitleLabel.frame = cardTitleRect;
    
    CGRect cardRemarkRect = _cardRemarkLabel.frame;
    cardRemarkRect.origin.y = [[self class] cellContentHeight:zero] + 20;
    _cardRemarkLabel.frame = cardRemarkRect;
    
    CGRect bgCellViewRect = _bgCellView.frame;
    bgCellViewRect.size.height = [[self class] cellContentHeight:zero] + _cardRemarkLabel.frame.size.height + 25;
    _bgCellView.frame = bgCellViewRect;
    
}

+ (CGFloat)cellContentHeight:(CardTypeModel *)content {
    
    CGFloat unChangeHeight = 45;
    CGRect rect = [content.cardTitle boundingRectWithSize:CGSizeMake(WIDTH-40, 10000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    
    return rect.size.height + unChangeHeight;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
