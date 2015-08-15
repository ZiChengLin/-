//
//  AFAppDotNetAPIClient.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/21.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface AFAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
