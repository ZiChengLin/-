//
//  SignTypeModel.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/17.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignTypeModel : NSObject

@property (nonatomic, strong) NSString *cardTitle;
@property (nonatomic, strong) NSString *cardRemark;
@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *pic1Path;

@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *authorName;

@end
