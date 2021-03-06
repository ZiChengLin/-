//
//  SignTypeCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/17.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "SignTypeCell.h"
#import "SignTypeModel.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation SignTypeCell

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
    _authorNameBtn.frame = CGRectMake(WIDTH-170, 10, 100, 20);
    //_authorNameBtn.backgroundColor = [UIColor orangeColor];
    _authorNameBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _authorNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;  // 设置按钮的内容进行左对齐
    [_authorNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_authorNameBtn];
    
    self.signBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _signBtn.frame = CGRectMake(WIDTH-60, 10, 40, 20);
    
    _signBtn.layer.masksToBounds = YES;
    _signBtn.layer.cornerRadius = 10;
    _signBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_signBtn];
    
    self.cardTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.authorNameBtn.frame.origin.y + 40, WIDTH-40, 0)];
    _cardTitleLabel.font = [UIFont systemFontOfSize:20];
    _cardTitleLabel.numberOfLines = 0;
    //_cardTitleLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_cardTitleLabel];
    
    self.cardTypeTwoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, WIDTH-40, HEIGHT/3-40)];
    //_cardTypeTwoImage.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_cardTypeTwoImage];
}

- (void)setSign:(SignTypeModel *)sign {
    
    _sign = sign;
    
    [_authorNameBtn setTitle:sign.authorName forState:UIControlStateNormal];
    
    int index = arc4random() % 10;
    if (index == 1) {
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:87.0/255 green:105.0/255 blue:60.0/255 alpha:1];
    } else if (index == 2) {
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:171.0/255 green:92.0/255 blue:37.0/255 alpha:1];
    } else if (index == 3) {
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:137.0/255 green:190.0/255 blue:178.0/255 alpha:1];
    } else if (index == 4) {
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:17.0/255 green:63.0/255 blue:61.0/255 alpha:1];
    } else if (index == 5) {
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:92.0/255 green:167.0/255 blue:186.0/255 alpha:1];
    } else if (index == 0){
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:255.0/255 green:66.0/255 blue:93.0/255 alpha:1];
    } else if (index == 6) {
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:32.0/255 green:36.0/255 blue:46.0/255 alpha:1];
    } else if (index == 7) {
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:119.0/255 green:52.0/255 blue:96.0/255 alpha:1];
    } else if (index == 8) {
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:28.0/255 green:120.0/255 blue:135.0/255 alpha:1];
    } else if (index == 9) {
        _signBtn.backgroundColor = [[UIColor alloc] initWithRed:138.0/255 green:151.0/255 blue:123.0/255 alpha:1];
    }
    
    _cardTitleLabel.text = sign.cardTitle;
    
    CGRect cardTitleRect = _cardTitleLabel.frame;
    cardTitleRect.size.height = [[self class] cellContentHeight:sign] - 45;
    _cardTitleLabel.frame = cardTitleRect;
    
    CGRect cardTypeTwoImageRect = _cardTypeTwoImage.frame;
    cardTypeTwoImageRect.origin.y = [[self class] cellContentHeight:sign] + 20;
    _cardTypeTwoImage.frame = cardTypeTwoImageRect;
    
    CGRect bgCellViewRect = _bgCellView.frame;
    bgCellViewRect.size.height = [[self class] cellContentHeight:sign] + _cardTypeTwoImage.frame.size.height + 25;
    _bgCellView.frame = bgCellViewRect;
    
}

+ (CGFloat)cellContentHeight:(SignTypeModel *)content {
    
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
