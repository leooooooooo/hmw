//
//  IndexViewController.m
//  iLygport
//
//  Created by leo on 15/1/5.
//  Copyright (c) 2015年 leo. All rights reserved.
//
#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width

#import "SecondViewController.h"
//#import "CustomURLCache.h"
#import "MBProgressHUD.h"
#import "Header.h"
#import <Leo/Leo.h>

@interface SecondViewController ()


@end

//#define URL @"http://218.92.115.55/M_hmw/index.html"

@implementation SecondViewController

- (void)viewDidLoad{
    /*
    CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                 diskCapacity:200 * 1024 * 1024
                                                                     diskPath:nil
                                                                    cacheTime:0];
    [CustomURLCache setSharedURLCache:urlCache];
     */
    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.webView.scrollView.bounds.size.height, self.webView.scrollView.frame.size.width, self.webView.scrollView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [self.webView.scrollView addSubview:_refreshHeaderView];
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    [super viewDidLoad];
    self.webView.delegate = self;
    self.webView.scalesPageToFit =YES;
    self.webView.scrollView.delegate = self;
    
    //初始化refreshView，添加到webview 的 scrollView子视图中
    //
    
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    [self loadPage];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *a = request.mainDocumentURL.absoluteString;
    NSString *b=self.webView.request.mainDocumentURL.absoluteString;
    
    //
    //NSLog(request.URL.absoluteString);
    if([[request.URL absoluteString]rangeOfString:@"More"].location!=NSNotFound && [[request.URL absoluteString]rangeOfString:@"info"].location!=NSNotFound)
    {
        return YES;
    }
    if([a isEqual:b])
    {
        return YES;
    }
    else
    {
        if (_qqq.mainDocumentURL) {
            return YES;
        }
        SecondViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"secondwebview"];
        asd.qqq = request;
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backButton];
        [asd.navigationItem setBackBarButtonItem:backButton];
        
        //[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"webview"]animated:YES];
        [self.navigationController pushViewController:asd animated:YES];
        return NO;
    }
    
    
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
    //NSURL *url = [[NSURL alloc] initWithString:URL];
    //if (_qqq.mainDocumentURL) {
        [self.webView loadRequest:_qqq];
    //}
    //else
    //{
    //    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //    [self.webView loadRequest:request];
    //}
}

#pragma mark - webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _reloading = YES;
        [HUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.webView.scrollView];
    //self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    //[customLab release];

    _qqq=nil;
    [HUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"load page error:%@", [error description]);
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.webView.scrollView];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
}




#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self.webView reload];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}

@end
