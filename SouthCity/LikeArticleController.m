//
//  LikeArticleController.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/22.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "LikeArticleController.h"
#import "NavigationController.h"
#import "DanduViewController.h"

#import "InstanceHandle.h"
#import "DataBaseHandle.h"
#import "DanduModel.h"
#import "LikeArticleCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface LikeArticleController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *tableView;

@end

@implementation LikeArticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"ARTICLE";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.tintColor = [UIColor blackColor];
    
    UIImage *image = [UIImage imageNamed:@"caidan"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:(NavigationController *)self.navigationController action:@selector(showMenu)];
    
    [self initTableView];
    [LikeArticleController setExtraCellLineHidden:self.tableView];

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
    
    return [[DataBaseHandle shareInstance] selectAllArticle].count;
}


-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DanduModel *dandu = [[DataBaseHandle shareInstance] selectAllArticle][indexPath.row];
    
    static NSString *cellIdentifier = @"likeArticlecell";
    LikeArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        
        cell = [[LikeArticleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.dandu = dandu;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return HEIGHT/8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DanduModel *dandu = [[DataBaseHandle shareInstance] selectAllArticle][indexPath.row];
    InstanceHandle *instance = [InstanceHandle shareInstance];
    instance.weburlStr = dandu.weburl;
    DanduViewController *dv = [[DanduViewController alloc] init];
    dv.dandu = dandu;
    dv.isHiddenString = @"YES";  // 
    [self presentViewController:dv animated:YES completion:^{
        
    }];
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
        
        DanduModel *dandu = [[DataBaseHandle shareInstance]selectAllArticle][indexPath.row];
        
        [[DataBaseHandle shareInstance] deleteArticle:dandu.theID];
        
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
