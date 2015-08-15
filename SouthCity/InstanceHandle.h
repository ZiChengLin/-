//
//  InstanceHandle.h
//  LuTiao
//
//  Created by 林梓成 on 15/7/9.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstanceHandle : NSObject

@property (assign)BOOL isEyeView;
@property (nonatomic, strong) NSString *weburlStr;

+ (InstanceHandle *)shareInstance;

@end
