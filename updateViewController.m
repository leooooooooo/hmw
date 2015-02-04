//
//  updateViewController.m
//  iLygport
//
//  Created by leo on 15/1/29.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "updateViewController.h"

@interface updateViewController ()

@end

@implementation updateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *urlString =self.url;
    webView.delegate = self;
    webView.scalesPageToFit =YES;
    [activityIndicatorView setCenter:self.view.center];
    [self loadWebPageWithString:urlString];
}

- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

//回调
//UIWebView委托方法，开始加载一个url时候调用此方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating];
}
//UIWebView委托方法，url加载完成的时候调用此方法
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
