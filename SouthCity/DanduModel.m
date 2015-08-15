//
//  DanduModel.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "DanduModel.h"

@implementation DanduModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        
        self.theID = [NSString stringWithFormat:@"%@", value];
    }

    if ([key isEqualToString:@"thumb"]) {
        
        NSArray *pictureArr = (NSArray *)value;
        NSDictionary *dic = pictureArr[0];
        self.url = dic[@"url"];
    }
    
    if ([key isEqualToString:@"updateTime"]) {
        
        NSDate *time = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        
        NSString *suffix = @"ago";
        float different = [time timeIntervalSinceNow];
        if (different < 0) {
            different = -different;
            suffix = @"前";
        }
        
        float dayDifferent = floor(different / 86400);
        
        int days   = (int)dayDifferent;
        int weeks  = (int)ceil(dayDifferent / 7);
        int months = (int)ceil(dayDifferent / 30);
        int years  = (int)ceil(dayDifferent / 365);
        
        if (dayDifferent <= 0) {

            if (different < 60) {
                self.updateTime = @"刚刚";
            }

            if (different < 120) {
                self.updateTime = [NSString stringWithFormat:@"1分钟%@", suffix];
            }
            
            if (different < 660 * 60) {
                self.updateTime = [NSString stringWithFormat:@"%d分钟%@", (int)floor(different / 60), suffix];
            }
            
            if (different < 7200) {
                self.updateTime = [NSString stringWithFormat:@"1小时%@", suffix];
            }
            
            if (different < 86400) {
                self.updateTime = [NSString stringWithFormat:@"%d小时%@", (int)floor(different / 3600), suffix];
            }
        }

        else if (days < 7) {
            self.updateTime = [NSString stringWithFormat:@"%d天%@", days, suffix];
        }
      
        else if (weeks < 4) {
            self.updateTime = [NSString stringWithFormat:@"%d周%@", weeks, suffix];
        }
    
        else if (months < 12) {
            self.updateTime = [NSString stringWithFormat:@"%d个月%@", months, suffix];
        }
        
        else {
            self.updateTime = [NSString stringWithFormat:@"%d年%@", years, suffix];
        }
    
    }
}

@end
