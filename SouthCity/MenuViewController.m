//
//  DEMOMenuViewController.m
//  REFrostedViewControllerExample
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015 Lin. All rights reserved.
//

#import "MenuViewController.h"
#import "HomeViewController.h"
#import "EyeHorizonViewController.h"
#import "ClassifyViewController.h"
#import "FeedBackViewController.h"
#import "LikeViewController.h"
#import "ArticleViewController.h"
#import "LikeArticleController.h"
#import "SceneViewController.h"
#import "UIViewController+REFrostedViewController.h"

#import "InstanceHandle.h"
#import "MenuViewCell.h"
#import "SDImageCache.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface MenuViewController ()
{
    UIAlertView *_alertView;
}
@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableHeaderView = ({
        
        // 184.0f
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, HEIGHT/3.60f)];
        
        /*
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
         imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
         imageView.image = [UIImage imageNamed:@""];
         imageView.layer.masksToBounds = YES;
         imageView.layer.cornerRadius = 50.0;
         imageView.layer.borderColor = [UIColor whiteColor].CGColor;
         imageView.layer.borderWidth = 3.0f;
         imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
         imageView.layer.shouldRasterize = YES;
         imageView.clipsToBounds = YES;
         [view addSubview:imageView];
         */
        
        /*
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 184.0f/2, WIDTH/5, HEIGHT/14)];
         imageView.image = [UIImage imageNamed:@"title.png"];
         //imageView.backgroundColor = [UIColor orangeColor];
         imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
         [view addSubview:imageView];
         */
        
        // set btn
        
        /*
         UIImageView *setBtnView = [[UIImageView alloc] initWithFrame:CGRectMake(-30, 184.0f/8, 32, 32)];
         setBtnView.image = [UIImage imageNamed:@""];
         setBtnView.backgroundColor = [UIColor yellowColor];
         setBtnView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
         [view addSubview:setBtnView];
         */
        
        
        UIImage *image = [UIImage imageNamed:@"qingchu"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        signBtn.frame = CGRectMake(-30, (HEIGHT/3.60f)/8, 32, 32);
        [signBtn setImage:image forState:UIControlStateNormal];
        signBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [signBtn addTarget:self action:@selector(setUpBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:signBtn];
        
        
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(-10, (HEIGHT/3.60f)/2, 150, 35)];
        name.text = @"WENQIN";
        name.font = [UIFont systemFontOfSize:28];
        name.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [view addSubview:name];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-100, name.frame.origin.y+35, WIDTH-60, 50)];
        //label.backgroundColor = [UIColor orangeColor];
        label.text = @"There is always a small thing in your life that makes you move.";
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        //[label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [view addSubview:label];
        
        view;
    });
    
    [MenuViewController setExtraCellLineHidden:self.tableView];
    [self initSignFont];
    
}

- (void)initSignFont {
    
    UIImageView *signView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2 + WIDTH/8, HEIGHT-HEIGHT/14 - 20, WIDTH/3, HEIGHT/14)];
    signView.image = [UIImage imageNamed:@"title3.png"];
    //signView.backgroundColor = [UIColor orangeColor];
    signView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.tableView addSubview:signView];
    
}

- (void)setUpBtn:(id)sender {
    
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    //NSLog(@"------%f", tmpSize/1000000);
    
    if (tmpSize/1000000 >= 1) {
        
        NSString *string = [NSString stringWithFormat:@"喵！清除了%.1fM缓存哦=_=", tmpSize/1000000];
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"" message:string delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
        [[SDImageCache sharedImageCache] clearDisk];
        
    } else if (tmpSize/1000000 > 0 && tmpSize/1000000 < 1){
        
        NSString *string = [NSString stringWithFormat:@"喵！清除了%.1fK缓存哦=_=", tmpSize/1000000 * 1024];
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"" message:string delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
        [[SDImageCache sharedImageCache] clearDisk];
        
    } else {
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"喵！缓存已经被清干净了哦=_=" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
    }
}

- (void)removeAlertView {
    
    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

/*
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
 {
 if (sectionIndex == 0)
 return nil;
 
 UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
 view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
 
 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
 label.text = @"Others";
 label.font = [UIFont systemFontOfSize:15];
 label.textColor = [UIColor whiteColor];
 label.backgroundColor = [UIColor clearColor];
 [label sizeToFit];
 [view addSubview:label];
 
 return view;
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
 {
 if (sectionIndex == 0)
 return 0;
 
 return 34;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UINavigationController *navigationController = (UINavigationController *)self.frostedViewController.contentViewController;
    
    if (indexPath.row == 0) {
        HomeViewController *homeViewController = [[HomeViewController alloc] init];
        navigationController.viewControllers = @[homeViewController];
    }
    
    if (indexPath.row == 1) {
        
        InstanceHandle *instance = [InstanceHandle shareInstance];
        instance.isEyeView = YES;
        HomeViewController *homeViewController = [[HomeViewController alloc] init];
        navigationController.viewControllers = @[homeViewController];
        
    } else if (indexPath.row == 2){
        LikeViewController *likeViewController = [[LikeViewController alloc] init];
        navigationController.viewControllers = @[likeViewController];
        
    } else if (indexPath.row == 3) {
        LikeArticleController *likeArticleViewController = [[LikeArticleController alloc] init];
        navigationController.viewControllers = @[likeArticleViewController];
        
    } else if (indexPath.row == 4) {
        SceneViewController *sceneViewController = [[SceneViewController alloc] init];
        navigationController.viewControllers = @[sceneViewController];
        
    } else if (indexPath.row == 5) {
        
        FeedBackViewController *feedBackViewController = [[FeedBackViewController alloc] init];
        navigationController.viewControllers = @[feedBackViewController];
    }
    
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT/12;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"menucell";
    
    MenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MenuViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 0) {
        
        cell.menuImageView.image = [UIImage imageNamed:@"home"];
        cell.menuLabel.text = @"首页";
    }else if (indexPath.row == 1) {
        
        cell.menuImageView.image = [UIImage imageNamed:@"shu"];
        cell.menuLabel.text = @"悦读";
        
    } else if (indexPath.row == 2) {
        
        cell.menuImageView.image = [UIImage imageNamed:@"love"];
        cell.menuLabel.text = @"我的喜欢";
    } else if (indexPath.row == 3) {
        
        cell.menuImageView.image = [UIImage imageNamed:@"du"];
        cell.menuLabel.text = @"我的文集";
        
    } else if (indexPath.row == 4) {
        
        cell.menuImageView.image = [UIImage imageNamed:@"about"];
        cell.menuLabel.text = @"关于WENQIN";
        
    } else if (indexPath.row == 5) {
        
        cell.menuImageView.image = [UIImage imageNamed:@"yijian"];
        cell.menuLabel.text = @"意见反馈";
    }
    
    return cell;
}

+ (void)setExtraCellLineHidden:(UITableView *)tableView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
    //[tableView setTableHeaderView:view];
    
}

@end
