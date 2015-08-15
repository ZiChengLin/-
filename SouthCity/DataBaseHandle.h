//
//  DataBaseHandle.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/20.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardTypeModel.h"
#import "DanduModel.h"

@interface DataBaseHandle : NSObject

+ (DataBaseHandle *)shareInstance;

- (void)initDataBase;

- (void)addNewXinLin:(CardTypeModel *)xinLin;
- (void)deleteXinLin:(NSString *)theID;
- (NSArray *)selectAllXinLin;
- (BOOL)isLikeXinLinWithID:(NSString *)ID;

- (void)addNewArticle:(DanduModel *)article;
- (void)deleteArticle:(NSString *)theID;
- (NSArray *)selectAllArticle;
- (BOOL)isLikeArticleWithID:(NSString *)ID;

@end
