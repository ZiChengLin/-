//
//  HomeViewController.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/15.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "HomeViewController.h"
#import "NavigationController.h"
#import "EyeHorizonViewController.h"
#import "ContentViewController.h"
#import "SignTypeViewController.h"
#import "ArticleViewController.h"

#import "CardTypeThirdCell.h"

#import "CardTypeModel.h"
#import "CardTypeTwoCell.h"
#import "CardTypeTwoFourCell.h"
#import "CardTypeTwoThridCell.h"

#import "CardTypeOneCell.h"
#import "CardTypeOneThirdCell.h"
#import "CardTypeOneFourCell.h"

#import "CardTypeZeroCell.h"
#import "CardTypeZeroThirdCell.h"
#import "CardTypeZeroFourCell.h"

#import "ApiUrl.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

#import "InstanceHandle.h"
#import "AFAppDotNetAPIClient.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIImageView              *bgView;
    CardTypeTwoCell          *twoCell;
    EyeHorizonViewController *_eye;
    ArticleViewController    *_article;
    HomeViewController       *_home;
    UIBarButtonItem          *switchBtnItem;
    UIAlertView              *alertView;
}
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *cardTypeTwoArray;

@end

@implementation HomeViewController

- (NSMutableArray *)cardTypeTwoArray {
    
    if (_cardTypeTwoArray == nil) {
        _cardTypeTwoArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _cardTypeTwoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    navigationLabel.text = @"文青－文艺青年的自留地";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;
    
    UIImage *image = [UIImage imageNamed:@"caidan"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:(NavigationController *)self.navigationController action:@selector(showMenu)];
    
    
    /*
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"NEXT"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(NavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
     
     self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
     
     */

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"Balloon"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    [SVProgressHUD show];
    //[self initBgView];
    [self initTableView];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH"];
    NSString *str = [dateformatter stringFromDate:[NSDate date]];
    int time = [str intValue];
    if (time >= 18 || time <= 06) {
        
        [self initFanPianData:FANPIAN2];
    } else {
        [self initFanPianData:FANPIAN2];
    }
    
    [self initArticleView];
    [self loadingMore];
    [self netWorkMonitor];

}

- (void)netWorkMonitor {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == 2) {
//            alertView = [[UIAlertView alloc] initWithTitle:@"SENSE" message:@"亲！您正处在WIFI中噢😊。"delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            [alertView show];
//            [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
            return;
        } else if (status == -1) {
            
            alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"晕！您这是啥网络吖😱。"delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
            [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
        } else if (status == 1) {
            
//            alertView = [[UIAlertView alloc] initWithTitle:@"WENQIN" message:@"亲！您这可是要花钱滴网络噢😏。"delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            [alertView show];
//            [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
            return;
        } else if (status == 0) {
            
            alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"崩！世界上最闹心滴事莫过于木有网络了💔。"delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
            [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
        }
    }];
    
}

- (void)removeAlertView {
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)initArticleView {
    
    UIImage *image = [[UIImage imageNamed:@"yang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    switchBtnItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(didClickSwitchBtnItem:)];
    self.navigationItem.rightBarButtonItem = switchBtnItem;
    
    _article = [[ArticleViewController alloc] init];
    
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:_article];
    na.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT-44);
    [self addChildViewController:na];
    
    _isShowHome = YES;
    
}

- (void)didClickSwitchBtnItem:(UIBarButtonItem *)btnItem {
    
    if (_isShowHome == NO) {
        
        UIImage *image = [[UIImage imageNamed:@"yang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        btnItem.image = image;
        [UIView transitionFromView:_article.view toView:self.view duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) completion:nil];
        
    } else {
        
        UIImage *image = [[UIImage imageNamed:@"xin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        btnItem.image = image;
        [UIView transitionFromView:self.view toView:_article.view duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) completion:nil];
        
    }
    
    _isShowHome = !_isShowHome;
}

- (void)initBgView {
    
    bgView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    bgView.image = [UIImage imageNamed:@"bg"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)initFanPianData:(NSString *)url {
    
    NSString *urlPath = url;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block HomeViewController *hv = self;
    [manager GET:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = operation.responseData;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        NSDictionary *dataDic = dict[@"data"];
        NSArray *digestListArr = dataDic[@"digestList"];
        
        for (NSDictionary *dic in digestListArr) {
            
            CardTypeModel *two = [[CardTypeModel alloc] init];
            [two setValuesForKeysWithDictionary:dic];
            [hv.cardTypeTwoArray addObject:two];
            
            // zan
            if ([two.signName isEqualToString:@"福利"]) {
                
                [hv.cardTypeTwoArray removeObject:two];
            }
        }
        if (hv.cardTypeTwoArray.count != 0) {
            
            [SVProgressHUD dismiss];
        }
        
        [hv.tableView reloadData];
        
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
    
    CardTypeModel *t = [self.cardTypeTwoArray lastObject];
    //NSLog(@"------%@", t.sortPage);
    NSString *sortPageStr = [NSString stringWithFormat:@"%@", t.sortPage];
    NSString *nextUrlPath = [AA stringByReplacingOccurrencesOfString:@"LinZiCheng" withString:sortPageStr];
    //NSLog(@"------%@", nextUrlPath);
    
    [self initFanPianData:nextUrlPath];
    [self.tableView.footer endRefreshing];
}

#pragma mark -- talbeView的代理方法

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cardTypeTwoArray.count;
}


-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CardTypeModel *two = self.cardTypeTwoArray[indexPath.row];
    
#pragma mark -- cardType is 3
    if ([two.cardType isEqualToString:@"3"]) {
        
        static NSString *cellIdentifier = @"cardTypeThridCell";
        
        CardTypeThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[CardTypeThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.zero = two;
        
        return cell;
    }
    
    
#pragma mark -- cardType is 2
    if ([two.cardType isEqualToString:@"2"] && [self countTheStrLength:two.signName] == 2) {
        
        static NSString *cellIdentifier = @"cardTypeTwoCell";
        twoCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == twoCell) {
            
            twoCell = [[CardTypeTwoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        twoCell.two = two;
        
        [twoCell.cardTypeTwoImage sd_setImageWithURL:[NSURL URLWithString:two.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [twoCell.signBtn addTarget:self action:@selector(signTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return twoCell;
    }
    
    if ([two.cardType isEqualToString:@"2"] && [self countTheStrLength:two.signName] == 3) {
        
        static NSString *cellIdentifier = @"cardTypeTwoThirdCell";
        CardTypeTwoThridCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[CardTypeTwoThridCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.two = two;
        [cell.cardTypeTwoImage sd_setImageWithURL:[NSURL URLWithString:two.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [cell.signBtn addTarget:self action:@selector(signTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    
    if ([two.cardType isEqualToString:@"2"] && [self countTheStrLength:two.signName] == 4) {
        
        static NSString *cellIdentifier = @"cardTypeTwoTwoCell";
        CardTypeTwoFourCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[CardTypeTwoFourCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.two = two;
        [cell.cardTypeTwoImage sd_setImageWithURL:[NSURL URLWithString:two.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
    
        [cell.signBtn addTarget:self action:@selector(signTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
#pragma mark -- cardType is 1
    if ([two.cardType isEqualToString:@"1"] && [self countTheStrLength:two.signName] == 2) {
    
        static NSString *cellIdentifier = @"cardTypeOneCell";
        CardTypeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[CardTypeOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.one = two;
        [cell.cardTypeOneImage sd_setImageWithURL:[NSURL URLWithString:two.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [cell.signBtn addTarget:self action:@selector(signTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    if ([two.cardType isEqualToString:@"1"] && [self countTheStrLength:two.signName] == 3) {
        
        static NSString *cellIdentifier = @"cardTypeOneThirdCell";
        CardTypeOneThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[CardTypeOneThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.one = two;
        [cell.cardTypeOneImage sd_setImageWithURL:[NSURL URLWithString:two.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [cell.signBtn addTarget:self action:@selector(signTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    if ([two.cardType isEqualToString:@"1"] && [self countTheStrLength:two.signName] == 4) {
        
        static NSString *cellIdentifier = @"cardTypeOneFourCell";
        CardTypeOneFourCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[CardTypeOneFourCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.one = two;
        [cell.cardTypeOneImage sd_setImageWithURL:[NSURL URLWithString:two.pic1Path] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        [cell.signBtn addTarget:self action:@selector(signTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
#pragma mark -- cardType is 0
    if ([two.cardType isEqualToString:@"0"] && [self countTheStrLength:two.signName] == 2) {
        
        static NSString *cellIdentifier = @"cardTypeZeroCell";
        CardTypeZeroCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[CardTypeZeroCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.zero = two;
        [cell.signBtn addTarget:self action:@selector(signTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    if ([two.cardType isEqualToString:@"0"] && [self countTheStrLength:two.signName] == 3) {
        
        static NSString *cellIdentifier = @"cardTypeZeroThirdCell";
        CardTypeZeroThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[CardTypeZeroThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.zero = two;
        
        [cell.signBtn addTarget:self action:@selector(signTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }

    if ([two.cardType isEqualToString:@"0"] && [self countTheStrLength:two.signName] == 4) {
        
        static NSString *cellIdentifier = @"cardTypeZeroFourCell";
        CardTypeZeroFourCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[CardTypeZeroFourCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.zero = two;
        
        [cell.signBtn addTarget:self action:@selector(signTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CardTypeModel *two = self.cardTypeTwoArray[indexPath.row];
    
    if ([two.cardType isEqualToString:@"2"]) {
        
        return HEIGHT/3-40 + [CardTypeTwoCell cellContentHeight:_cardTypeTwoArray[indexPath.row]] + 35;
        
    } else if ([two.cardType isEqualToString:@"1"]) {
        
        return HEIGHT/5 + [CardTypeTwoCell cellContentHeight:_cardTypeTwoArray[indexPath.row]] + 35;

    } else if ([two.cardType isEqualToString:@"0"]) {
        
        return HEIGHT/6 + [CardTypeTwoCell cellContentHeight:_cardTypeTwoArray[indexPath.row]] + 35;
    } else if ([two.cardType isEqualToString:@"3"]) {
        
        return HEIGHT/6 + [CardTypeTwoCell cellContentHeight:_cardTypeTwoArray[indexPath.row]] + 35;
    }
        
        return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CardTypeModel *two = self.cardTypeTwoArray[indexPath.row];
    
    ContentViewController *content = [[ContentViewController alloc] init];
    
    content.urlId = two.theID;
    content.cardTitleStr = two.cardTitle;
    content.pictureStr = two.pic1Path;
    content.cardRemarkStr = two.cardRemark;
    content.contentModel = two;
    
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

- (void)signTypeBtn:(id)sender {
    
    SignTypeViewController *sv = [[SignTypeViewController alloc] init];
    
    // 点击该按钮时知道该按钮所在的cell在TableView中的行数
    NSInteger index = [self.tableView indexPathForCell:((UITableViewCell*)[[sender superview]superview])].row;
    
    CardTypeModel *two = self.cardTypeTwoArray[index];
    sv.titleString = two.signName;
    sv.signIdString = two.signID;
    
    [self.navigationController pushViewController:sv animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    // ...网络监测
    //[AFAppDotNetAPIClient sharedClient];
   
    // ...非常重要
    InstanceHandle *instance = [InstanceHandle shareInstance];
    if (instance.isEyeView == YES) {
        
        UIImage *image = [[UIImage imageNamed:@"xin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        switchBtnItem.image = image;

        [UIView transitionFromView:self.view toView:_article.view duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) completion:nil];
        
        _isShowHome = NO;    // the key
        
    }
    instance.isEyeView = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
