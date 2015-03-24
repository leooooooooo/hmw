//
//  changeInfoViewController.m
//  iLygport
//
//  Created by leo on 15/2/10.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "changeInfoViewController.h"
#import "AppDelegate.h"

@interface changeInfoViewController ()

@end

@implementation changeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *url = [NSString stringWithFormat:@"http://218.92.115.55/M_hmw/getservice/getpersondetaildata.aspx?userid=%@",delegate.userid];
    NSURL *get=[NSURL URLWithString:url];
    NSMutableURLRequest *rq=[NSMutableURLRequest requestWithURL:get];
    NSData *rc =[NSURLConnection sendSynchronousRequest:rq returningResponse:nil error:nil];
    NSString *rcc=[[NSString alloc]initWithData:rc encoding:NSUTF8StringEncoding];
    NSArray *info = [rcc componentsSeparatedByString:@","];
    if (info.count==0) {
        info = [[NSArray alloc]initWithObjects:@"0",@"0",@"0",nil];
    }
    self.tel.text = [info objectAtIndex:1];
    self.email.text = [info objectAtIndex:2];
    self.phone.text = [info objectAtIndex:0];
    // Do any additional setup after loading the view.
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

- (IBAction)clearemail:(id)sender {
    self.email.text = nil;
}

- (IBAction)cleartel:(id)sender {
    self.tel.text = nil;
}

- (IBAction)clearphone:(id)sender {
    self.phone.text = nil;
}

- (IBAction)sendInfo:(id)sender {
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *url = [NSString stringWithFormat:@"http://218.92.115.55/M_hmw/getservice/updatepersondetaildata.aspx?userid=%@&email=%@&mobile=%@&phone=%@",delegate.userid,self.email.text,self.tel.text,self.phone.text];
    NSURL *get=[NSURL URLWithString:url];
    NSMutableURLRequest *rq=[NSMutableURLRequest requestWithURL:get];
    NSData *rc =[NSURLConnection sendSynchronousRequest:rq returningResponse:nil error:nil];
    NSString *rcc=[[NSString alloc]initWithData:rc encoding:NSUTF8StringEncoding];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:rcc message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end
