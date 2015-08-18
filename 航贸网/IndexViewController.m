//
//  IndexViewController.m
//  iLygport
//
//  Created by leo on 15/1/5.
//  Copyright (c) 2015年 leo. All rights reserved.
//
#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width
#define UpdateAlertViewTag 1


#import "IndexViewController.h"
#import "SecondViewController.h"
#import "CygnViewController.h"
#import "CustomURLCache.h"
#import "MBProgressHUD.h"
#import "Header.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface IndexViewController ()
@property(retain,nonatomic)NSURLRequest *qqq;


@end

#define URL @"http://218.92.115.55/M_hmw/index.html"

@implementation IndexViewController

- (void)viewDidLoad{
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self GetUpdateInfo];
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
    
    
    //nav button
    //UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(Cygn:)];
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithTitle:@"常用" style:UIBarButtonItemStyleDone target:self action:@selector(Cygn:)];
    //UIImage *redbutton =[UIImage imageNamed:@"redbutton.png"];
    
    //[select setBackgroundImage:redbutton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    select.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:select];

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
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
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
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.webView.scrollView];
    //self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    //self.navigationItem.titleView.backgroundColor=[UIColor whiteColor];
    _qqq=nil;
    [SVProgressHUD dismiss];
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

- (void)Cygn:(id)sender {

    CygnViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"cygnwebview"];
    info=[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    asd.userid  = [info objectForKey:(id)kSecAttrAccount];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [asd.navigationItem setBackBarButtonItem:backButton];
    [backButton release];
    //[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"webview"]animated:YES];
    [self.navigationController pushViewController:asd animated:YES];

}

-(void)GetUpdateInfo
{
    //1确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"http://218.92.115.55/MobilePlatform/Update.aspx"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //2建立请求NSMutableURLRequest（post需要用这个）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //网络访问超时时间
    [request setTimeoutInterval:20.0f];
    //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
    [request setHTTPMethod:@"POST"];
    //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
    NSString *bodyStr = [NSString stringWithFormat:@"AppName=%@&DeviceType=iOS&Build=%@",AppName,[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    //将nstring转换成nsdata
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"body data %@", body);
    [request setHTTPBody:body];
    
    //这里是非代理的异步请求，异步请求并不会阻止主线程的继续执行，不用等待网络请结束。
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError * error) {
        //这段块代码只有在网络请求结束以后的后续处理。
        UIAlertView *alert;
        if (data != nil) {  //接受到数据，表示工作正常
            //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *Update = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            delegate.Update = [Update objectForKey:@"Update"];
            NSLog(@"%@", Update);
            
            if([[Update objectForKey:@"Update"]isEqualToString:@"Yes"])
            {
                delegate.Url = [Update objectForKey:@"Url"];
                delegate.Version = [Update objectForKey:@"Version"];
                alert = [[UIAlertView alloc]initWithTitle:@"更新" message:[NSString stringWithFormat:@"检测到新版本%@，请点击更新安装新版本",[Update objectForKey:@"Version"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                alert.tag =UpdateAlertViewTag;
                [alert show];
                /*
                //版本更新button
                UIButton *newVersion = [[UIButton alloc]initWithFrame:CGRectMake(20, self.view.bounds.size.height-85, 200, 30)];
                [newVersion setTitle:[NSString stringWithFormat:@"最新版本：%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Version]] forState:UIControlStateNormal];
                newVersion.titleLabel.font = [UIFont boldSystemFontOfSize:14];
                [newVersion setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
                newVersion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [newVersion addTarget:self action:@selector(CheckUpdate) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:newVersion];
                 */
                
                
            }
            else
            {
                //alert = [[UIAlertView alloc]initWithTitle:@"更新" message:@"当前已经是最新版本" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            }
        }
        else
        {
            if(data == nil && error == nil)    //没有接受到数据，但是error为nil。。表示接受到空数据。
            {
               // alert = [[UIAlertView alloc]initWithTitle:@"更新失败" message:@"更新失败，网络超时" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            }
            else
            {
                //alert = [[UIAlertView alloc]initWithTitle:@"更新失败" message:error.localizedDescription delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                NSLog(@"%@", error.localizedDescription);  //请求出错。
            }
        }
        
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag)
    {
        case UpdateAlertViewTag:
            switch (buttonIndex)
        {
            case 1:[self Update];break;
            default:break;
        }
            break;
            
        default:break;
    }
}

-(void)Update
{
    UIWebView *up = [[[UIWebView alloc]init]autorelease];
    NSURL *url =[NSURL URLWithString:[(AppDelegate *)[[UIApplication sharedApplication]delegate]Url]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [up loadRequest:request];
    [self.view addSubview:up];
    NSLog(@"开始更新",nil);
    
}

-(void)viewDidAppear:(BOOL)animated{
    //[self hideTabBar];
    [super viewDidAppear:animated];
    [self showTabBar];
}

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}


-(void)dealloc
{
    [super dealloc];
    [_refreshHeaderView release];
}
@end
