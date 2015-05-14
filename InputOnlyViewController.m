//
//  InputOnlyViewController.m
//  iLygport
//
//  Created by leo on 15/3/12.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "InputOnlyViewController.h"
#import "SVProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import "SecondViewController.h"

@interface InputOnlyViewController ()

@end

@implementation InputOnlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //输入名称
    UILabel *shenhelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,60, self.view.frame.size.width, 40)];
    shenhelabel.text = [NSString stringWithFormat:@"                        %@",self.inputLabelName];
    shenhelabel.font = [UIFont systemFontOfSize:15];
    shenhelabel.backgroundColor = [UIColor grayColor];
    shenhelabel.userInteractionEnabled = YES;
    [self.view addSubview:shenhelabel];
    
    
    //输入框
    UITextField *lb = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2,67,120,30)];
    lb.backgroundColor=[UIColor whiteColor];
    lb.layer.cornerRadius = 5.0 ;
    lb.borderStyle = UITextBorderStyleRoundedRect;
    lb.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    [lb addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEnd];
    [lb setAutocorrectionType:UITextAutocorrectionTypeNo];
    lb.tag = 2;
    [self.view addSubview:lb];
    //查询按钮
    //UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithTitle:@"查询" style:UIBarButtonItemStyleDone target:self action:@selector(select:)];
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(select:)];

    
    //UIImage *redbutton =[UIImage imageNamed:@"redbutton.png"];
    
    //[select setBackgroundImage:redbutton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    select.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:select];
    //分割线
    UILabel *fenge = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 2)];
    fenge.backgroundColor = [UIColor redColor];
    fenge.text = @"";
    [self.view addSubview:fenge];
    //web
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 102, self.view.frame.size.width,self.view.frame.size.height-102)];
    
    webView.delegate =self;
    webView.scalesPageToFit =YES;
    [self.view addSubview:webView];
    webView.tag = 1;
    
    
    [self select:self];
    // Do any additional setup after loading the view.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([[request.URL absoluteString]rangeOfString:@"Detail"].location!=NSNotFound)
    {
        SecondViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"secondwebview"];
        asd.qqq = request;
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backButton];
        [asd.navigationItem setBackBarButtonItem:backButton];
        //[backButton release];
        //[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"webview"]animated:YES];
        [self.navigationController pushViewController:asd animated:YES];
        
        return NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing
{
    [((UITextField *)[self.view viewWithTag:2]) resignFirstResponder];
}

-(void)select:(id)sender
{

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSMutableString *urlString = [[NSMutableString alloc]initWithFormat:self.url,nil];
    [urlString appendFormat:@"?info=%@+%@",self.userID, [((UITextField *)[self.view viewWithTag:2]).text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
