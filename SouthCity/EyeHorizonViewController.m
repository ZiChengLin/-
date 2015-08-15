//
//  EyeHorizonViewController.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/16.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "EyeHorizonViewController.h"
#import "DanduCell.h"
#import "DanduModel.h"
#import "DanduViewController.h"
#import "InstanceHandle.h"

#import "ApiUrl.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface EyeHorizonViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIImageView *bgView;
}

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *danDuArray;

@end

@implementation EyeHorizonViewController

- (NSMutableArray *)danDuArray {
    
    if (_danDuArray == nil) {
        
        _danDuArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _danDuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SVProgressHUD show];
    
    [self initBgView];
    [self initTableView];
    [self initDanduData];
    
    if (self.danDuArray.count != 0) {
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    } else {
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)initDanduData {
    
    NSString *urlPath = DANDU;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block EyeHorizonViewController *ev = self;
    [manager GET:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       NSData *data = operation.responseData;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *articleArr = dict[@"article"];
        
        for (NSDictionary *dic in articleArr) {
            
            DanduModel *dandu = [[DanduModel alloc] init];
            [dandu setValuesForKeysWithDictionary:dic];
            [ev.danDuArray addObject:dandu];
           
        }
        
        if (ev.danDuArray.count != 0) {
            
            [SVProgressHUD dismiss];
        }
        
        [ev.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载错误--%@", error);
    }];
    
}

- (void)initBgView {
    
    bgView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    bgView.image = [UIImage imageNamed:@"bg"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //_tableView.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:_tableView];
}

#pragma mark -- talbeView的代理方法

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.danDuArray.count;
}


-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ddcell";
    DanduCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        
        cell = [[DanduCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    DanduModel *dandu = self.danDuArray[indexPath.row];
    cell.dandu = dandu;
    
    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:dandu.url] placeholderImage:[UIImage imageNamed:@"missing_article"]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return HEIGHT/3 + 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    InstanceHandle *instance = [InstanceHandle shareInstance];
    
    DanduModel *dandu = self.danDuArray[indexPath.row];
    instance.weburlStr = dandu.weburl;
    
    DanduViewController *dv = [[DanduViewController alloc] init];
    
    [self presentViewController:dv animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
