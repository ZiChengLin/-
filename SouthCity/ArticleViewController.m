//
//  ArticleViewController.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/22.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ArticleViewController.h"
#import "NavigationController.h"

#import "ApiUrl.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "InstanceHandle.h"

#import "DanduModel.h"
#import "DanduViewController.h"
#import "ArticleCollectionCell.h"
#import "SVProgressHUD.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ArticleViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    ArticleCollectionCell *cell;
}
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *danDuArray;

@end

@implementation ArticleViewController

- (NSMutableArray *)danDuArray {
    
    if (_danDuArray == nil) {
        _danDuArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _danDuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD show];
    
    [self initCollectionView];
    [self initArticleData];
}

- (void)initCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(WIDTH/2-1, WIDTH/2-1);
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 2;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) collectionViewLayout:flowLayout];
    _collection.backgroundColor = [UIColor clearColor];
    _collection.delegate = self;
    _collection.dataSource = self;
    [self.view addSubview:_collection];
    
    [_collection registerClass:[ArticleCollectionCell class] forCellWithReuseIdentifier:@"articleCell"];
}

- (void)initArticleData {
    
    NSString *urlPath = DANDU;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block ArticleViewController *av = self;
    [manager GET:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = operation.responseData;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *articleArr = dict[@"article"];
        
        for (NSDictionary *dic in articleArr) {
            
            DanduModel *dandu = [[DanduModel alloc] init];
            [dandu setValuesForKeysWithDictionary:dic];
            [av.danDuArray addObject:dandu];
            
        }
        
        if (av.danDuArray.count != 0) {
            
            [SVProgressHUD dismiss];
        }
        
        [av.collection reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载错误--%@", error);
    }];
    
}

#pragma -mark 实现协议方法  UICollectionViewDataSource的代理方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.danDuArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"articleCell" forIndexPath:indexPath];
    
    DanduModel *dandu = self.danDuArray[indexPath.row];
    cell.dandu = dandu;
    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:dandu.url] placeholderImage:[UIImage imageNamed:@"missing_article"]];
    
    return cell;
}

#pragma -mark 点击集合视图的item执行的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    InstanceHandle *instance = [InstanceHandle shareInstance];
    
    DanduModel *dandu = self.danDuArray[indexPath.row];
    instance.weburlStr = dandu.weburl;
    
    DanduViewController *dv = [[DanduViewController alloc] init];
    dv.dandu = dandu;
    dv.titleString = dandu.title;
    dv.urlString = dandu.url;
    dv.weburlString = dandu.weburl;
    [self presentViewController:dv animated:YES completion:^{
        
    }];
}

#pragma -mark 设置集合视图item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(WIDTH/2-1, WIDTH/2-1);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
