//
//  DEMOSecondViewController.m
//  REFrostedViewControllerExample
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015 Lin. All rights reserved.
//

#import "ClassifyViewController.h"
#import "NavigationController.h"

#import "ApiUrl.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "ClassifyCell.h"
#import "ClassifyModel.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ClassifyViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    ClassifyCell *cell;
}
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray   *classifyArray;
@property (nonatomic, strong) NSArray          *titleArray;

@end

@implementation ClassifyViewController

- (NSMutableArray *)classifyArray {
    
    if (_classifyArray == nil) {
        
        _classifyArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _classifyArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"CLASSIFY";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(NavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
    */
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"HOME" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    [self initCollectionView];
    [self initClassifyData];
}

- (void)back:(id)sender {
    
    
}

- (void)initClassifyData {
    
    NSString *urlPth = FENLEI;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block ClassifyViewController *sv = self;
    [manager GET:urlPth parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = operation.responseData;
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in array) {
            
            ClassifyModel *classify = [[ClassifyModel alloc] init];
            [classify setValuesForKeysWithDictionary:dic];
            [sv.classifyArray addObject:classify];
        }
        
        [self.collection reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载错误--%@", error);
    }];
    
    
    
}

- (void)initCollectionView {
    
    self.titleArray = [[NSArray alloc]initWithObjects:@"#创业",@"#治愈",@"#旅行",@"#成长",@"#恋爱心理",@"#电影",@"#一个人",@"#悦食",@"#漫画",@"#生活", nil];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(WIDTH/2-1, WIDTH/2-1);
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 2;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    
    self.collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collection.backgroundColor = [UIColor clearColor];
    _collection.delegate = self;
    _collection.dataSource = self;
    [self.view addSubview:_collection];
    
    [_collection registerClass:[ClassifyCell class] forCellWithReuseIdentifier:@"classifyCell"];
}

#pragma -mark 实现协议方法  UICollectionViewDataSource的代理方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.classifyArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classifyCell" forIndexPath:indexPath];
    
    ClassifyModel *classify = self.classifyArray[indexPath.row];
    cell.classify = classify;
    cell.titleLabel.text = self.titleArray[indexPath.row];
    
    [cell.bgPictureImageView sd_setImageWithURL:[NSURL URLWithString:classify.bgPicture] placeholderImage:[UIImage imageNamed:@"missing_article"]];
    
    return cell;
}

#pragma -mark 点击集合视图的item执行的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"--%ld--%ld", indexPath.section, indexPath.row);
}

#pragma -mark 设置集合视图item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(WIDTH/2-1, WIDTH/2-1);
}



@end
