//
//  AFAppDotNetAPIClient.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/21.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "AFAppDotNetAPIClient.h"

@interface AFAppDotNetAPIClient ()

@end

static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                    break;
                default:
                    break;
            }
        }];
        [_sharedClient.reachabilityManager startMonitoring];
    });
    
    return _sharedClient;
}

@end
