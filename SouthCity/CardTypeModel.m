//
//  CardTypeTwoModel.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/15.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "CardTypeModel.h"

@implementation CardTypeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"cardType"]) {
        
        self.cardType = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"id"]) {
        
        self.theID = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"authorList"]) {
        
        NSArray *authorListArr = (NSArray *)value;
        NSDictionary *authorDic = authorListArr[0];
        self.authorId = [NSString stringWithFormat:@"%@", authorDic[@"authorId"]];
        self.authorName = authorDic[@"name"];
    }
    
    if ([key isEqualToString:@"signList"]) {
        
        NSArray *signListArr = (NSArray *)value;
        NSDictionary *signDic = signListArr[0];
        self.signID = [NSString stringWithFormat:@"%@", signDic[@"id"]];
        self.signName = signDic[@"name"];
    }
    
}

@end
