//
//  DanduViewController.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "DanduViewController.h"
#import "InstanceHandle.h"
#import "EyeHorizonViewController.h"
#import "SVProgressHUD.h"

#import "DataBaseHandle.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface DanduViewController ()<UIWebViewDelegate>
{
    UIAlertView *_alertView;
    UIButton    *_collectionBtn;
}

@property (strong, nonatomic)UIWebView *webView;

@end

@implementation DanduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(getBack:)];
    //self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    //[SVProgressHUD show];
    
    InstanceHandle *instance = [InstanceHandle shareInstance];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:instance.weburlStr]];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
    [self initSubViewBtns];
}

- (void)initSubViewBtns {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(-10, HEIGHT/5, 60, 32)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 10;
    [self.view addSubview:backView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(15, 0, 45, 32);
    [btn setTitle:@"BACK" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(WIDTH-100+20, HEIGHT-50, 100, 32)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10;
    [self.view addSubview:view];
    
    _collectionBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _collectionBtn.frame = CGRectMake(5, 0, 32, 32);
    
    if ([[DataBaseHandle shareInstance] isLikeArticleWithID:self.dandu.theID]) {
        
        UIImage *collectionImage = [[UIImage imageNamed:@"like_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_collectionBtn setImage:collectionImage forState:UIControlStateNormal];
        [_collectionBtn addTarget:self action:@selector(collectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_collectionBtn];
        
    } else {
        
        UIImage *collectionImage = [[UIImage imageNamed:@"like_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_collectionBtn setImage:collectionImage forState:UIControlStateNormal];
        [_collectionBtn addTarget:self action:@selector(collectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_collectionBtn];
    }
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    shareBtn.frame = CGRectMake(45, 0, 32, 32);
    UIImage *shareImage = [[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [shareBtn setImage:shareImage forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:shareBtn];

    if (self.isHiddenString) {
        
        [view removeFromSuperview];
    }
}

#pragma mark - webView代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    //[SVProgressHUD dismiss];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    //[SVProgressHUD dismiss];
}


- (void)getBack:(id)sender {

    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)btn:(id)sender {
    
    InstanceHandle *instance = [InstanceHandle shareInstance];
    instance.isEyeView = YES;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)collectionBtn:(id)sender {
    
    if (![[DataBaseHandle shareInstance] isLikeArticleWithID:self.dandu.theID]) {
        
        UIImage *collectionImage = [[UIImage imageNamed:@"like_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [_collectionBtn setImage:collectionImage forState:UIControlStateNormal];
        CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        k.values = @[@(0.1),@(1.0),@(1.5)];
        k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
        k.calculationMode = kCAAnimationLinear;
        [_collectionBtn.layer addAnimation:k forKey:@"SHOW"];
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"亲！已经收藏到文集里面了喔Q_Q" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
        
        [[DataBaseHandle shareInstance] addNewArticle:self.dandu];
        
        
    } else {
        
        UIImage *collectionImage = [[UIImage imageNamed:@"like_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [_collectionBtn setImage:collectionImage forState:UIControlStateNormal];
        CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        k.values = @[@(0.1),@(1.0),@(1.5)];
        k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
        k.calculationMode = kCAAnimationLinear;
        [_collectionBtn.layer addAnimation:k forKey:@"SHOW"];
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"亲！你真的要抛弃我？T_T"delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
        
        [[DataBaseHandle shareInstance] deleteArticle:self.dandu.theID];
    }

}

- (void)removeAlertView {
    
    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)shareBtn:(id)sender {
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.urlString]];
    
    NSString *String = [self.titleString stringByAppendingFormat:@"\n%@", self.weburlString];
    NSString *shareString = [String stringByAppendingString:@"\n(内容来自文青)"];

    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55af076b67e58e24070007cf"
                                      shareText:shareString
                                     shareImage:imgView.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatTimeline,UMShareToDouban,UMShareToRenren,nil]
                                       delegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
