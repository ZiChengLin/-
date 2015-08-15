//
//  LikeViewController.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/20.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "LikeViewController.h"
#import "NavigationController.h"
#import "ContentViewController.h"

#import "DataBaseHandle.h"
#import "CardTypeModel.h"
#import "LikeViewCell.h"
#import "LikeOneViewCell.h"
#import "LikeZeroViewCell.h"


#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface LikeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *tableView;

@end

@implementation LikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"LIKE";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.tintColor = [UIColor blackColor];
    
    UIImage *image = [UIImage imageNamed:@"caidan"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:(NavigationController *)self.navigationController action:@selector(showMenu)];
    
    [self initTableView];
    [LikeViewController setExtraCellLineHidden:self.tableView];

    
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //self.tableView.bounces = NO;
    //_tableView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_tableView];
}

#pragma mark -- talbeView的代理方法

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[DataBaseHandle shareInstance] selectAllXinLin].count;
}


-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CardTypeModel *cardType = [[DataBaseHandle shareInstance] selectAllXinLin][indexPath.row];
    
    //NSLog(@"---%@", cardType.cardType);
    
    if ([cardType.cardType isEqualToString:@"2"]) {
        
        static NSString *cellIdentifier = @"liketwocell";
        LikeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[LikeViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.cardType = cardType;
        
        return cell;
    } else if ([cardType.cardType isEqualToString:@"1"]) {
        
        static NSString *cellIdentifier = @"likeonecell";
        LikeOneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[LikeOneViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.cardType = cardType;
        
        return cell;
    } else if ([cardType.cardType isEqualToString:@"0"]) {
        
        static NSString *cellIdentifier = @"likezerocell";
        LikeZeroViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[LikeZeroViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.cardType = cardType;
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return HEIGHT/8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CardTypeModel *cardType = [[DataBaseHandle shareInstance] selectAllXinLin][indexPath.row];
    
    ContentViewController *content = [[ContentViewController alloc] init];
    content.urlId = cardType.theID;
    content.cardTitleStr = cardType.cardTitle;
    content.signNameStr = cardType.signName;
    
    [self.navigationController pushViewController:content animated:YES];
}

#pragma mark - 编辑的代理方法 （与侧滑菜单手势冲突）

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView beginUpdates];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        CardTypeModel *cardType = [[DataBaseHandle shareInstance]selectAllXinLin][indexPath.row];
        
        [[DataBaseHandle shareInstance] deleteXinLin:cardType.theID];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:YES];
    [_tableView setEditing:editing animated:YES];
}

+ (void)setExtraCellLineHidden:(UITableView *)tableView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
