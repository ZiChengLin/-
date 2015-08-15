//
//  MenuViewCell.m
//  LuTiao
//
//  Created by 林梓成 on 15/7/12.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "MenuViewCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation MenuViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

- (void) initSubViews {
    
    self.menuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 11, 32, 32)];
    //_menuImageView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_menuImageView];
    
    self.menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.menuImageView.frame.size.width + 60, 11, 100, 32)];
    //_menuLabel.backgroundColor = [UIColor orangeColor];
    _menuLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _menuLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_menuLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
