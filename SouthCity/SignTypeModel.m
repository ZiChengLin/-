//
//  SignTypeModel.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/17.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "SignTypeModel.h"

@implementation SignTypeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key {

    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"cardType"]) {
        
        self.cardType = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"id"]) {
        
        self.ID = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"authorList"]) {
        
        NSArray *authorListArr = (NSArray *)value;
        NSDictionary *authorDic = authorListArr[0];
        self.authorId = [NSString stringWithFormat:@"%@", authorDic[@"authorId"]];
        self.authorName = authorDic[@"name"];
    }

}

@end
