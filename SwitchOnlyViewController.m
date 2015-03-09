//
//  SwitchOnlyViewController.m
//  iLygport
//
//  Created by leo on 15/3/5.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "SwitchOnlyViewController.h"

@interface SwitchOnlyViewController ()

@end

@implementation SwitchOnlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //审核状态
    UILabel *shenhelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,60, self.view.frame.size.width, 40)];
    shenhelabel.text = @"                        已审核";
    shenhelabel.font = [UIFont systemFontOfSize:15];
    shenhelabel.backgroundColor = [UIColor grayColor];
    shenhelabel.userInteractionEnabled = YES;
    [self.view addSubview:shenhelabel];
    
    
    //审核按钮
    UISwitch *shenheSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/3,67,60,40)];
    shenheSwitch.tag = 2;
    [self.view addSubview:shenheSwitch];
    //查询按钮
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithTitle:@"查询" style:UIBarButtonSystemItemSearch target:self action:@selector(select:)];
    
    
    UIImage *redbutton =[UIImage imageNamed:@"redbutton.png"];
    
    [select setBackgroundImage:redbutton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
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
    
    
    
    // Do any additional setup after loading the view.
}

-(void)select:(id)sender
{
    NSString *adt = [[NSString alloc]init];
    if([((UISwitch *)[self.view viewWithTag:2]) isOn])
    {
        adt = @"1";
    }
    else
    {
        adt = @"0";
    }
    
    NSMutableString *urlString = [[NSMutableString alloc]initWithFormat:self.url];
    [urlString appendFormat:@"?info=%@+%@",self.userID,adt];
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [((UIWebView *)[self.view viewWithTag:1]) loadRequest:request];
    //NSLog(urlString);
}

- (void)didReceiveMemoryWarning
{
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
