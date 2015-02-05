//
//  MessageDetailViewController.m
//  iLygport
//
//  Created by leo on 15/2/5.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "Header.h"
@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.URL = [NSString stringWithFormat:@"http://218.92.115.55/M_hmw/detail/Detail_Message.html?msgid=%@",self.msgid];
    [super viewDidLoad];
    self.webView.delegate = self;
    self.webView.scalesPageToFit =YES;
    self.webView.scrollView.delegate = self;
    
    //初始化refreshView，添加到webview 的 scrollView子视图中
    //
    
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    [self loadPage];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    //self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dict;

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

//-(CGFloat)getLastHeight
//{
//    UIView *a =  self.indexScrollView.subviews.lastObject;
//    return a.frame.size.height;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    //[urlCache removeAllCachedResponses];
}

//加载网页
- (void)loadPage {
    NSURL *url = [[NSURL alloc] initWithString:self.URL];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    
}



@end
