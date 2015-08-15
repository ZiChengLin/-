//
//  SignTypeViewController.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/17.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "SignTypeViewController.h"

#import "DateNextModel.h"
#import "SignTypeModel.h"

#import "SignTypeCell.h"
#import "SignTypeThirdCell.h"
#import "SignTypeFourCell.h"

#import "OneSignTypeCell.h"
#import "OneSignTypeThirdCell.h"
#import "OneSignTypeFourCell.h"

#import "ZeroSignTypeCell.h"
#import "ZeroSignTypeFourCell.h"
#import "ZeroSignTypeThirdCell.h"

#import "ContentViewController.h"

#import "ApiUrl.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface SignTypeViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIImageView  *bgView;
    UIAlertView  *_alertView;
    
}
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *signTypeArray;
@property (nonatomic, strong) NSMutableArray *dateNextArray;     // 取出时间和hasNext字段
@end

@implementation SignTypeViewController

- (NSMutableArray *)signTypeArray {
    
    if (_signTypeArray == nil) {
        
        _signTypeArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _signTypeArray;
}

- (NSMutableArray *)dateNextArray {
    
    if (_dateNextArray == nil) {
        
        _dateNextArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _dateNextArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(getBack:)];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.title = self.titleString;
    
    [SVProgressHUD show];
    
    [self initBgView];
    [self initTableView];
    NSString *url = [TYPE stringByReplacingOccurrencesOfString:@"LinZiCheng" withString:self.signIdString];
    [self initsignTypeData:url];
    
    [self loadingMore];
}

- (void)getBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)initBgView {
    
    bgView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    bgView.image = [UIImage imageNamed:@"bg"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //_tableView.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:_tableView];
}

- (void)initsignTypeData:(NSString *)url {
    
    NSString *urlPth = url;
    //NSLog(@"----%@", urlPth);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block SignTypeViewController *sv = self;
    [manager GET:urlPth parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = operation.responseData;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dataDic = dict[@"data"];
        
        // 事实证明 要取出数据需有模型和字典配合使用
        DateNextModel *datenext = [[DateNextModel alloc] init];
        datenext.currentDate = dataDic[@"currentDate"];
        datenext.hasNext = dataDic[@"hasNext"];
        [sv.dateNextArray addObject:datenext];
        
        NSArray *digestListArr = dataDic[@"digestList"];
        
        for (NSDictionary *dic in digestListArr) {
            
            SignTypeModel *sign = [[SignTypeModel alloc] init];
            [sign setValuesForKeysWithDictionary:dic];
            [sv.signTypeArray addObject:sign];
        }
        
        if (sv.signTypeArray.count != 0) {
            
            [SVProgressHUD dismiss];
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
         NSLog(@"下载错误--%@", error);
    }];
    
}

- (void)loadingMore {
    
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self performSelector:@selector(refreshMore) withObject:nil afterDelay:0.5f];
    }];
    [self.tableView.header beginRefreshing];
    
    
    //上拉加载
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self performSelector:@selector(loadedMore) withObject:nil afterDelay:0.5f];
    }];

}

- (void)refreshMore {
    
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
}

- (void)loadedMore {
    
    [self.tableView.footer beginRefreshing];
    DateNextModel *datenext = [self.dateNextArray lastObject];
    NSString *hasNextStr = [NSString stringWithFormat:@"%@", datenext.hasNext];   // 默认是bool类型
    SignTypeModel *sign = [self.signTypeArray lastObject];
    if ([hasNextStr isEqualToString:@"1"]) {
        
        //NSLog(@"---%@", sign.createTime);
        NSString *createTimeStr = [NSString stringWithFormat:@"%@", sign.createTime];
        NSString *nextUrlPath = [BB stringByReplacingOccurrencesOfString:@"LinZiCheng" withString:createTimeStr];
        
        [self initsignTypeData:nextUrlPath];
    } else {
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"SENSE" message:@"亲！没有更多的了哦" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:0.8];

    }
    [self.tableView.footer endRefreshing];
}

- (void)removeAlertView {
    
    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark -- talbeView的代理方法

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.signTypeArray.count;
}

-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SignTypeModel *sign = self.signTypeArray[indexPath.row];
    
    
#pragma mark -- cardType=2
    if ([sign.cardType isEqualToString:@"2"] && [self countTheStrLength:self.titleString] == 2) {
        
        static NSString *cellIdentifier = @"twocell";
        SignTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[SignTypeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.sign = sign;
        [cell.cardTypeTwoImage sd_setImageWithURL:[NSURL URLWithString:sign.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        [cell.signBtn setTitle:self.titleString forState:UIControlStateNormal];
        
        return cell;
    }
    
    
    if ([sign.cardType isEqualToString:@"2"] && [self countTheStrLength:self.titleString] == 3) {
        
        static NSString *cellIdentifier = @"thirdcell";
        SignTypeThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[SignTypeThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.third = sign;
        [cell.cardTypeTwoImage sd_setImageWithURL:[NSURL URLWithString:sign.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [cell.signBtn setTitle:self.titleString forState:UIControlStateNormal];
        
        return cell;
    }
    
    if ([sign.cardType isEqualToString:@"2"] && [self countTheStrLength:self.titleString] == 4) {
        
        static NSString *cellIdentifier = @"fourcell";
        SignTypeFourCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[SignTypeFourCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.four = sign;
        [cell.cardTypeTwoImage sd_setImageWithURL:[NSURL URLWithString:sign.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [cell.signBtn setTitle:self.titleString forState:UIControlStateNormal];
        
        return cell;
    }

#pragma mark -- signType=1
    if ([sign.cardType isEqualToString:@"1"] && [self countTheStrLength:self.titleString] == 2) {
        
        static NSString *cellIdentifier = @"oneSignTypeCell";
        OneSignTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[OneSignTypeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.one = sign;
        [cell.cardTypeOneImage sd_setImageWithURL:[NSURL URLWithString:sign.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [cell.signBtn setTitle:self.titleString forState:UIControlStateNormal];

        return cell;
    }
    
    if ([sign.cardType isEqualToString:@"1"] && [self countTheStrLength:self.titleString] == 3) {
        
        static NSString *cellIdentifier = @"oneSignTypeThirdCell";
        OneSignTypeThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[OneSignTypeThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.one = sign;
        [cell.cardTypeOneImage sd_setImageWithURL:[NSURL URLWithString:sign.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [cell.signBtn setTitle:self.titleString forState:UIControlStateNormal];
        
        return cell;
    }

    if ([sign.cardType isEqualToString:@"1"] && [self countTheStrLength:self.titleString] == 4) {
        
        static NSString *cellIdentifier = @"oneSignTypeFourCell";
        OneSignTypeFourCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[OneSignTypeFourCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.one = sign;
        [cell.cardTypeOneImage sd_setImageWithURL:[NSURL URLWithString:sign.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [cell.signBtn setTitle:self.titleString forState:UIControlStateNormal];
        
        return cell;
    }

    
#pragma mark -- cardType is 0
    if ([sign.cardType isEqualToString:@"0"] && [self countTheStrLength:self.titleString] == 2) {
        

        static NSString *cellIdentifier = @"zeroSignTypeCell";
        ZeroSignTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[ZeroSignTypeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.zero = sign;
        [cell.signBtn setTitle:self.titleString forState:UIControlStateNormal];
        
        return cell;
    }
    
    if ([sign.cardType isEqualToString:@"0"] && [self countTheStrLength:self.titleString] == 3) {
        
        
        static NSString *cellIdentifier = @"zeroSignTypeThirdCell";
        ZeroSignTypeThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[ZeroSignTypeThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.zero = sign;
        [cell.signBtn setTitle:self.titleString forState:UIControlStateNormal];
        
        return cell;
    }

    if ([sign.cardType isEqualToString:@"0"] && [self countTheStrLength:self.titleString] == 4) {
        
        
        static NSString *cellIdentifier = @"zeroSignTypeFourCell";
        ZeroSignTypeFourCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[ZeroSignTypeFourCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.zero = sign;
        [cell.signBtn setTitle:self.titleString forState:UIControlStateNormal];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SignTypeModel *sign = self.signTypeArray[indexPath.row];
    
    if ([sign.cardType isEqualToString:@"2"]) {
        
        return HEIGHT/3-40 + [SignTypeCell cellContentHeight:_signTypeArray[indexPath.row]] + 35;
    } else if ([sign.cardType isEqualToString:@"1"]) {
        
        return HEIGHT/5 + [OneSignTypeCell cellContentHeight:_signTypeArray[indexPath.row]] + 35;
    } else if ([sign.cardType isEqualToString:@"0"]) {
        
        return HEIGHT/6 + [ZeroSignTypeCell cellContentHeight:_signTypeArray[indexPath.row]] + 35;
    } else
        
        return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SignTypeModel *sign = self.signTypeArray[indexPath.row];
    
    ContentViewController *content = [[ContentViewController alloc] init];
    content.urlId = sign.ID;
    content.cardTitleStr = sign.cardTitle;
    content.signNameStr = sign.authorName;
    
    [self.navigationController pushViewController:content animated:YES];
    
}

- (int)countTheStrLength:(NSString *)strtemp {
    
    int strlength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength + 1)/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
