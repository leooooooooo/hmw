//
//  EmptyViewController.m
//  iLygport
//
//  Created by leo on 15/3/10.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "EmptyViewController.h"
#import "SVProgressHUD.h"

@interface EmptyViewController ()

@end

@implementation EmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //查询按钮
    //UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithTitle:@"查询" style:UIBarButtonItemStyleDone target:self action:@selector(select:)];
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(select:)];

    
    //UIImage *redbutton =[UIImage imageNamed:@"redbutton.png"];
    
    //[select setBackgroundImage:redbutton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    select.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:select];

    //web
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height+60)];
    
    webView.delegate =self;
    webView.scalesPageToFit =YES;
    [self.view addSubview:webView];
    webView.tag = 1;
    
    
    [self select:self];
    // Do any additional setup after loading the view.
}

-(void)select:(id)sender
{

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSMutableString *urlString = [[NSMutableString alloc]initWithFormat:self.url,nil];
    [urlString appendFormat:@"?info=%@",self.userID];
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [((UIWebView *)[self.view viewWithTag:1]) loadRequest:request];
    //NSLog(urlString);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
