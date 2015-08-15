//
//  CardTypeTwoModel.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/15.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardTypeModel : NSObject

@property (nonatomic, strong) NSString *currentDate;

@property (nonatomic, strong) NSString *cardTitle;
@property (nonatomic, strong) NSString *cardRemark;
@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *theID;
@property (nonatomic, strong) NSString *pic1Path;

@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *authorName;

@property (nonatomic, strong) NSString *signID;
@property (nonatomic, strong) NSString *signName;

@property (nonatomic, strong) NSString *sortPage;

@end
