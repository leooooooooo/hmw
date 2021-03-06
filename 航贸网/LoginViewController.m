//
//  ViewController.m
//  航贸网
//
//  Created by leo on 14/11/9.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "LoginViewController.h"
#import "Header.h"
#import "AppDelegate.h"

#define WebService @"http://218.92.115.55/M_hmw/SERVICEHMW.ASMX"
#define SendName login
#define Result @"GetLoginResult"
#define SoapName @"GetLogin"
#define Token @"MV4FGbDeCY/c0E5Xh9k8Mg=="

#define key1 @"<logogram>%@</logogram>",self.ID.text
#define key2 @"<password>%@</password>",self.PW.text
#define key3 @"<deviceID>%@</deviceID>",devicetoken
#define key4 @"<DeviceType>iOS</DeviceType>"
#define key5 @"<snsToken>%@</snsToken>",nil
#define key6 @""
#define key7 @""
#define key8 @""



@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //webservice
    ServiceMobileApplication =WebService;
    soapmsg1 = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
    "<soap12:Envelope "
    "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
    "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
    "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
    "<soap12:Body>";
    soapmsg2 = @"</soap12:Body>"
    "</soap12:Envelope>";
    soapmsg = [[NSMutableString alloc]init];
    
    //keychain
    self.keepkeyswitch.on = NO;
    self.autologinswitch.on = NO;
    
        

    //从keychain里取出帐号密码状态
    KeyChain = [NSUserDefaults standardUserDefaults];
    
    self.keepkeyswitch.on = [KeyChain boolForKey:@"KeepKey"];
    self.autologinswitch.on = [KeyChain boolForKey:@"AutoLogin"];
    self.ID.text = [KeyChain objectForKey:@"UserName"];
    self.PW.text = [KeyChain objectForKey:@"Password"];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([KeyChain boolForKey:@"AutoLogin"]) {
        [self signinbt];
    }
    
    self.autologinswitch.on = [KeyChain boolForKey:@"AutoLogin"];

    [self hideTabBar];
}


-(IBAction)signinbt{
    
    soap *SendName=[[soap alloc]init];
    SendName.sendDelegate=self;
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    [SendName matchingElement:Result];
    // 创建SOAP消息，内容格式就是网站上提示的请求报文的实体主体部分
    
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *devicetoken=delegate.deviceToken;
    
    soapmsg= nil;
    soapmsg = [[NSMutableString alloc]init];
    [soapmsg appendFormat:soapmsg1,nil];
    NSString *soapname = SoapName;
    NSString *token =Token;
    [soapmsg appendFormat:@"<%@ xmlns=\"http://tempuri.org/\">",soapname];
    [soapmsg appendFormat:@"<token>%@</token>",token];
    [soapmsg appendFormat:key1];
    [soapmsg appendFormat:key2];
    [soapmsg appendFormat:key3];
    [soapmsg appendFormat:key4];
    [soapmsg appendFormat:key5];
    [soapmsg appendFormat:key6];
    [soapmsg appendFormat:key7];
    [soapmsg appendFormat:key8];
    [soapmsg appendFormat:@"</%@>",soapname];
    [soapmsg appendFormat:soapmsg2,nil];
    [SendName soapMsg:soapmsg];
    [SendName url:ServiceMobileApplication];
    [SendName send];
    //[self performSegueWithIdentifier:@"login" sender:self]; //断网
    
    }

- (IBAction)keepkey:(id)sender {
    if (![sender isOn]){
        [KeyChain removeObjectForKey:@"Password"];
    }
}

- (IBAction)autologin:(id)sender {
    [KeyChain setBool:self.autologinswitch.isOn forKey:@"AutoLogin"];
}

- (IBAction)keyboarddisapper:(id)sender {
    [self.ID resignFirstResponder];
    [self.PW resignFirstResponder];
}

- (IBAction)topassword:(id)sender {
    [self.PW becomeFirstResponder];
}

- (IBAction)dis:(id)sender {
    [sender resignFirstResponder];
}

-(void)returnxml:(NSString *)xml{
    parser *pp = [[[parser alloc]init]autorelease];
    pp.send=self;
    [pp nsxmlparser:xml];
    //pp = nil;
}

-(void)returnparser:(NSMutableArray *)parser{
    if ([[[parser objectAtIndex:0]objectAtIndex:0]isEqualToString:@"True"])
    {
            AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            delegate.isbinding = [[parser objectAtIndex:1]objectAtIndex:3];

        /*

*/
        [self performSegueWithIdentifier:@"login" sender:self];

        
        //保存按钮状态
        [KeyChain setBool:self.autologinswitch.isOn forKey:@"AutoLogin"];
        [KeyChain setBool:self.keepkeyswitch.isOn forKey:@"KeepKey"];
        [KeyChain synchronize];
        
        if (self.keepkeyswitch.isOn) {
            [KeyChain setObject:self.ID.text forKey:@"UserName"];
            [KeyChain setObject:self.PW.text forKey:@"Password"];
            [KeyChain synchronize];
        }
        //保存登录信息
        info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
        [info setObject:[[parser objectAtIndex:1]objectAtIndex:0] forKey:(id)kSecAttrAccount];//userid
        [info setObject:[[parser objectAtIndex:1]objectAtIndex:1] forKey:(id)kSecValueData];//companyid
        isbinding =[[KeychainItemWrapper alloc] initWithIdentifier:@"isbinding"accessGroup:Bundle];
        [isbinding setObject:[[parser objectAtIndex:1]objectAtIndex:3]forKey:(id)kSecValueData];//isbinding
        
        AppDelegate *da=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        da.userid=[[parser objectAtIndex:1]objectAtIndex:0];

    }
    if ([[[parser objectAtIndex:0]objectAtIndex:0]isEqualToString:@"False"]) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[[parser objectAtIndex:0]objectAtIndex:1] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }
    //NSLog([[parser objectAtIndex:0]objectAtIndex:0]);
    
    
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


- (void)dealloc {
    [_keepkeyswitch release];
    [_autologinswitch release];
    [super dealloc];
}
@end

