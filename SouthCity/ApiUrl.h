//
//  ApiUrl.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/15.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#ifndef SouthCity_ApiUrl_h
#define SouthCity_ApiUrl_h

// 白天
#define FANPIAN2 @"http://e.dangdang.com/media/api2.go?pageSize=15&act=new&action=getDigestHomePageList&dayOrNight=day&returnType=json&deviceType=FP_Android&channelId=61001&clientVersionNo=1.0.2&serverVersionNo=1.0.0&permanentId=20150709021854034186283669863647986&deviceSerialNo=869630014445773&macAddr=c4%3A6a%3Ab7%3Abc%3A10%3Aaf&resolution=720*1280&clientOs=4.1.1&platformSource=FP-P&channelType=all&token="

// 白天的详情
#define WCONTENT @"http://e.dangdang.com//media/api2.go?action=getDigestContentForH5&digestId=2195&returnType=json&deviceType=FP_Android&channelId=61001&clientVersionNo=1.0.2&serverVersionNo=1.0.0&permanentId=20150709021854034186283669863647986&deviceSerialNo=869630014445773&macAddr=c4%3A6a%3Ab7%3Abc%3A10%3Aaf&resolution=720*1280&clientOs=4.1.1&platformSource=FP-P&channelType=all&token="

// 黑夜
#define FANPIAN @"http://e.dangdang.com/media/api2.go?pageSize=15&act=new&action=getDigestHomePageList&dayOrNight=night&returnType=json&deviceType=FP_Android&channelId=61001&clientVersionNo=1.0.2&serverVersionNo=1.0.0&permanentId=20150709021854034186283669863647986&deviceSerialNo=869630014445773&macAddr=c4%3A6a%3Ab7%3Abc%3A10%3Aaf&resolution=720*1280&clientOs=4.1.1&platformSource=FP-P&channelType=all&token="

// 黑夜的详情
#define NCONTENT @"http://e.dangdang.com//media/api2.go?action=getDigestContentForH5&digestId=LinZiCheng&returnType=json&deviceType=FP_Android&channelId=61001&clientVersionNo=1.0.2&serverVersionNo=1.0.0&permanentId=20150709021854034186283669863647986&deviceSerialNo=869630014445773&macAddr=c4%3A6a%3Ab7%3Abc%3A10%3Aaf&resolution=720*1280&clientOs=4.1.1&platformSource=FP-P&channelType=all&token="

// 刷新数据的
#define AA      @"http://e.dangdang.com/media/api2.go?pageSize=15&action=getDigestHomePageList&dayOrNight=day&sortPage=LinZiCheng&act=old&returnType=json&deviceType=FP_Android&channelId=61001&clientVersionNo=1.0.2&serverVersionNo=1.0.0&permanentId=20150709021854034186283669863647986&deviceSerialNo=869630014445773&macAddr=c4%3A6a%3Ab7%3Abc%3A10%3Aaf&resolution=720*1280&clientOs=4.1.1&platformSource=FP-P&channelType=all&token="

// 类型 signId = ?
#define TYPE    @"http://e.dangdang.com/media/api2.go?pageSize=15&action=getDigestListBySign&signId=LinZiCheng&returnType=json&deviceType=FP_Android&channelId=61001&clientVersionNo=1.0.2&serverVersionNo=1.0.0&permanentId=20150709021854034186283669863647986&deviceSerialNo=869630014445773&macAddr=c4%3A6a%3Ab7%3Abc%3A10%3Aaf&resolution=720*1280&clientOs=4.1.1&platformSource=FP-P&channelType=all&token="

// 类型 刷新数据的 &createTime=1436253916000&   createTime=?
#define BB     @"http://e.dangdang.com/media/api2.go?pageSize=15&action=getDigestListBySign&signId=120&createTime=LinZiCheng&returnType=json&deviceType=FP_Android&channelId=61001&clientVersionNo=1.0.2&serverVersionNo=1.0.0&permanentId=20150709021854034186283669863647986&deviceSerialNo=869630014445773&macAddr=c4%3A6a%3Ab7%3Abc%3A10%3Aaf&resolution=720*1280&clientOs=4.1.1&platformSource=FP-P&channelType=all&token="

// DANDU
#define DANDU  @"http://content.cdn.onewaystreet.cn/v5/app10/issue_80/category/content-getcatindex-10-2-80-76_1432612278.api"

// YIXI
#define YIXI   @"http://api.yixi.tv/api/v1/album"

// 分类
#define FENLEI @"http://baobab.wandoujia.com/api/v1/categories"


#endif
