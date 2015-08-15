//
//  DataBaseHandle.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/20.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "DataBaseHandle.h"
#import "FMDatabase.h"

@interface DataBaseHandle ()
{
    FMDatabase *_fmDB;
}
@end

@implementation DataBaseHandle

static DataBaseHandle *handle = nil;

+ (DataBaseHandle *)shareInstance {
    
    if (nil == handle) {
        
        handle = [[DataBaseHandle alloc] init];
        [handle initDataBase];
    }
    return handle;
}


- (void)initDataBase {
    
    if (_fmDB != nil) {
        
        return;
    }
    // 获得Documents目录路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"lin.sqlite"];
   //NSLog(@"%@", documentsPath);
    
    if (!_fmDB) {
        
        // 实例化FMDatabase对象
        _fmDB = [FMDatabase databaseWithPath:filePath];
    }
    // 打开数据库
    [_fmDB open];
    // 初始化喜欢的数据表
    [_fmDB executeUpdate:@"CREATE TABLE ZiChengTable(id INTEGER PRIMARY KEY AUTOINCREMENT,cardType TEXT,theID TEXT,cardTitle TEXT,cardRemark TEXT, pic1Path TEXT, authorName TEXT, signName TEXT)"];
    
    // 创建文章的数据表
    [_fmDB executeUpdate:@"CREATE TABLE XiaoChunTable(id INTEGER PRIMARY KEY AUTOINCREMENT, theID TEXT, title TEXT, url TEXT, weburl TEXT)"];
    
    [_fmDB close];
    
}

// 添加数据
- (void)addNewXinLin:(CardTypeModel *)xinLin {
    
    [_fmDB open];
    [_fmDB executeUpdate:@"INSERT INTO ZiChengTable(cardType,theID,cardTitle,cardRemark,pic1Path,authorName,signName)VALUES(?,?,?,?,?,?,?)",xinLin.cardType,xinLin.theID,xinLin.cardTitle,xinLin.cardRemark,xinLin.pic1Path,xinLin.authorName,xinLin.signName];
    [_fmDB close];
}

// 删除数据
- (void)deleteXinLin:(NSString *)theID {
    
    [_fmDB open];
    [_fmDB executeUpdate:@"DELETE FROM ZiChengTable WHERE theID = ?",theID];   // 删除数据需注意
    [_fmDB close];
}


// 获取全部数据
- (NSArray *)selectAllXinLin {
    
    [_fmDB open];
    
    FMResultSet *res = [_fmDB executeQuery:@"SELECT * FROM ZiChengTable"];
    
    NSMutableArray *allData = [NSMutableArray array];
    while ([res next]) {
        
        NSString *_cardType = [res stringForColumnIndex:1];
        NSString *_theid = [res stringForColumnIndex:2];          // 这里index不是从零开始的
        NSString *_cardTitle = [res stringForColumnIndex:3];
        NSString *_cardRemark = [res stringForColumnIndex:4];
        NSString *_pic1Path = [res stringForColumnIndex:5];
        NSString *_authorName = [res stringForColumnIndex:6];
        NSString *_signName = [res stringForColumnIndex:7];
        
        CardTypeModel *c = [[CardTypeModel alloc] init];
        c.cardType = _cardType;
        c.cardRemark = _cardRemark;
        c.theID = _theid;
        c.cardTitle = _cardTitle;
        c.pic1Path = _pic1Path;
        c.authorName = _authorName;
        c.signName = _signName;
        
        [allData addObject:c];
    }
    
    [_fmDB close];
    
    return allData;
}

- (BOOL)isLikeXinLinWithID:(NSString *)ID {
    
    [_fmDB open];
    FMResultSet *set = [_fmDB executeQueryWithFormat:@"SELECT * FROM ZiChengTable WHERE theID = %@;", ID];
    
    while (set.next)
        return YES;
    
    return NO;
}

#pragma mark -- 文章数据库操作

- (void)addNewArticle:(DanduModel *)article {
    
    [_fmDB open];
    [_fmDB executeUpdate:@"INSERT INTO XiaoChunTable(theID,title,url,weburl)VALUES(?,?,?,?)", article.theID, article.title, article.url, article.weburl];
    [_fmDB close];
}

- (void)deleteArticle:(NSString *)theID {
    
    [_fmDB open];
    [_fmDB executeUpdate:@"DELETE FROM XiaoChunTable WHERE theID = ?", theID];
    [_fmDB close];
}

- (NSArray *)selectAllArticle {
    
    [_fmDB open];
    
    FMResultSet *res = [_fmDB executeQuery:@"SELECT * FROM XiaoChunTable"];
    
    NSMutableArray *allData = [NSMutableArray array];
    while ([res next]) {
        
        NSString *_theid = [res stringForColumnIndex:1];
        NSString *_title = [res stringForColumnIndex:2];
        NSString *_url = [res stringForColumnIndex:3];
        NSString *_weburl = [res stringForColumnIndex:4];
        
        DanduModel *d = [[DanduModel alloc] init];
        d.theID = _theid;
        d.title = _title;
        d.url = _url;
        d.weburl = _weburl;
        
        [allData addObject:d];
    }
    [_fmDB close];
    
    return allData;
}

- (BOOL)isLikeArticleWithID:(NSString *)ID {
    
    [_fmDB open];
    FMResultSet *set = [_fmDB executeQueryWithFormat:@"SELECT * FROM XiaoChunTable WHERE theID = %@;", ID];
    
    while (set.next)
        return YES;
    
    return NO;
    
}

@end
