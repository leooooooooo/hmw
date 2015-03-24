//
//  phcxViewController.m
//  iLygport
//
//  Created by leo on 15/2/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "CompanySwitchViewController.h"
#import "DropDownListView.h"
#import "SVProgressHUD.h"


@interface CompanySwitchViewController (){
    NSMutableArray *chooseArray ;
    NSString *companyID;
}


@end

@implementation CompanySwitchViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"票货查询";
    
    //下拉菜单
    chooseArray = [NSMutableArray arrayWithArray:@[
                                                   @[@"东联公司",@"东源公司",@"东泰公司",@"新东润公司",@"灌河国际",@"新陆桥公司",@"新苏港公司",@"新海湾公司",@"新圩港公司"],
                                                   @[@"郏童熙",@"胥童嘉",@"郑嘉琦"]
                                                   ]];
    companyID = [NSString stringWithFormat:@"010111"];
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,60, self.view.frame.size.width, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    
    
    [self.view addSubview:dropDownView];

    //审核状态
    UILabel *shenhelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2,60, self.view.frame.size.width/2, 40)];
    shenhelabel.text = @"        已审核";
    shenhelabel.font = [UIFont systemFontOfSize:15];
    shenhelabel.backgroundColor = [UIColor grayColor];
    shenhelabel.userInteractionEnabled = YES;
    [self.view addSubview:shenhelabel];
    
    
    //审核按钮
    UISwitch *shenheSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60,67,60,40)];
    shenheSwitch.tag = 2;
    [self.view addSubview:shenheSwitch];
    //查询按钮
    //UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:@selector(select:)];
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

-(void)select:(id)sender
{
    NSString *adt = @"";
    if([((UISwitch *)[self.view viewWithTag:2]) isOn])
    {
        adt = @"1";
    }
    else
    {
        adt = @"0";
    }
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSMutableString *urlString = [[NSMutableString alloc]initWithFormat:self.url,nil];
    [urlString appendFormat:@"?info=%@+%@+%@",companyID,self.userID,adt];
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


#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{

    switch (index) {
        case 0:
            companyID = @"010111";   //东联
            break;
        case 1:
            companyID = @"010113";   //东源
            break;
        case 2:
            companyID = @"010116";   //东泰
            break;
        case 3:
            companyID = @"010118";   //东润
            break;
        case 4:
            companyID = @"010121";   //灌河国际
            break;
        case 5:
            companyID = @"010219";   //新陆桥
            break;
        case 6:
            companyID = @"010246";   //新苏港
            break;
        case 7:
            companyID = @"010249";   //新海湾
            break;
        case 8:
            companyID = @"010250";   //新圩港
            break;
        default:
            break;
    }
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
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
