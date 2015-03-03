//
//  IndexViewController.m
//  iLygport
//
//  Created by leo on 15/1/5.
//  Copyright (c) 2015年 leo. All rights reserved.
//
#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width


#import "IndexViewController.h"
#import "SecondViewController.h"
#import "CygnViewController.h"
#import "CustomURLCache.h"
#import "MBProgressHUD.h"
#import "Header.h"
#import "updateViewController.h"
#import "AppDelegate.h"


@interface IndexViewController ()
@property(retain,nonatomic)NSURLRequest *qqq;


@end

#define URL @"http://218.92.115.55/M_hmw/index.html"

@implementation IndexViewController

- (void)viewDidLoad{
    

    NSURL *urljson=[NSURL URLWithString:@"http://gw.api.taobao.com/router/rest?sign=DB7B5CE419527C0ABD5C626D36C4426A&timestamp=2013-07-02+13:52:53&v=2.0&app_key=21553302&method=taobao.itemprops.get&partner_id=top-apitools&format=json&cid=50012379&fields=pid,name,must,multi,prop_values"];
                    NSURLRequest *request=[NSURLRequest  requestWithURL:urljson];
                    //发送同步请求
                    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                    NSError *error;
                    NSDictionary *dicdata=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self checkupdate];
    /*
    CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:0.1 * 1024 * 1024
                                                                 diskCapacity:0.1 * 1024 * 1024
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
    info=[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    NSString *userid  = [info objectForKey:(id)kSecAttrAccount];
    if ([userid isEqualToString:@"0"]|[userid isEqualToString:@""]) {
    }
    else
    {
        self.SignInButton.hidden=YES;
    }
    AppDelegate *da=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    da.userid = userid;

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *a = request.mainDocumentURL.absoluteString;
    NSString *b=self.webView.request.mainDocumentURL.absoluteString;

    if([a isEqual:b]|[a isEqualToString:URL])
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
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backButton];
        [asd.navigationItem setBackBarButtonItem:backButton];
        [backButton release];
        //[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"webview"]animated:YES];
        [self.navigationController pushViewController:asd animated:YES];
        
        return NO;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
}

//加载网页
- (void)loadPage {
    NSURL *url = [[[NSURL alloc] initWithString:URL]autorelease];
    if (_qqq.mainDocumentURL) {
        [self.webView loadRequest:_qqq];
    }
    else
    {
    NSURLRequest *request = [[[NSURLRequest alloc] initWithURL:url]autorelease];
    [self.webView loadRequest:request];
    }
}

#pragma mark - webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _reloading = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.webView.scrollView];
    //self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    //self.navigationItem.titleView.backgroundColor=[UIColor whiteColor];
    _qqq=nil;
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

- (IBAction)Cygn:(id)sender {

    CygnViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"cygnwebview"];
    info=[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    asd.userid  = [info objectForKey:(id)kSecAttrAccount];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [asd.navigationItem setBackBarButtonItem:backButton];
    [backButton release];
    //[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"webview"]animated:YES];
    [self.navigationController pushViewController:asd animated:YES];

}

-(void)checkupdate
{
    NSString *url = [NSString stringWithFormat:@"http://218.92.115.55/M_hmw/getservice/HMWUPDATE.ASPX?deviceType=iOS&version=%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    NSURL *get=[NSURL URLWithString:url];
    NSMutableURLRequest *rq=[NSMutableURLRequest requestWithURL:get];
    NSData *rc =[NSURLConnection sendSynchronousRequest:rq returningResponse:nil error:nil];
    NSString *rcc=[[[NSString alloc]initWithData:rc encoding:NSUTF8StringEncoding]autorelease];;
    NSString *pb;
    UIAlertView *alert;
    if([rcc isEqualToString:@"yes"]|[rcc isEqualToString:@"yes\r\n"])
    {
        //pb = [NSString stringWithFormat:@"当前版本为%@，已经是最新版本",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        //alert = [[UIAlertView alloc]initWithTitle:@"版本更新" message:pb delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        //[alert show];
    }
    else
    {
        pb = [NSString stringWithFormat:@"检测到最新版本%@，请更新",rcc];
        alert = [[[UIAlertView alloc]initWithTitle:@"版本更新" message:pb delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil]autorelease];
        [alert show];
        NSString *url = [NSString stringWithFormat:@"http://218.92.115.55/m_hmw/install/install.html"];
        updateViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"updatewebview"];
        asd.url = url;
        
        UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil]autorelease];
        [self.navigationItem setBackBarButtonItem:backButton];
        [asd.navigationItem setBackBarButtonItem:backButton];
        [self.navigationController pushViewController:asd animated:YES];
    }
    
}



-(void)dealloc
{
    [super dealloc];
    [_refreshHeaderView release];
}
@end
