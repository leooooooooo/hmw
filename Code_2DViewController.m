//
//  Code_2DViewController.m
//  hmw
//
//  Created by zhangchao on 15/11/2.
//  Copyright © 2015年 leo. All rights reserved.
//

#import "Code_2DViewController.h"
#import <Leo/Leo.h>
#define NoNull(object) (object && ![object isEqual:[NSNull null]])?object:@""

@interface Code_2DViewController ()
@end

@implementation Code_2DViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];

}

- (void)viewDidLoad {
    
    int o = self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication]statusBarFrame].size.height;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSString *URL =@"http://www.baidu.com";
    
    NSString *department = NoNull([_data valueForKey:@"DEPARTMENT"]);
    NSString *company =NoNull([_data valueForKey:@"CLIENT"]);
    NSString *taskno =NoNull([_data valueForKey:@"TASKNO"]);
    NSString *sendtime1 =NoNull([_data valueForKey:@"SUBMITTIME"]);
    NSString *sendtime2 =NoNull([_data valueForKey:@"SUBMITTIME"]);
    NSString *sendtime3 =NoNull([_data valueForKey:@"SUBMITTIME"]);
    NSString *cargo =NoNull([_data valueForKey:@"CARGO"]);
    NSString *mark =NoNull([_data valueForKey:@"MARK"]);
    NSString *ship =NoNull([_data valueForKey:@"VESSEL_VOYAGE"]);
    NSString *ticket =NoNull([_data valueForKey:@"BLNO"]);
    NSString *empty =NoNull([_data valueForKey:@"WEIGHT1"]);
    NSString *loaded =NoNull([_data valueForKey:@"WEIGHT2"]);
    NSString *tons =NoNull([_data valueForKey:@"WEIGHTCARGO"]);
    NSString *number =@"";
    NSString *carno =NoNull([_data valueForKey:@"VEHICLE"]);
    NSString *driver =NoNull([_data valueForKey:@"DRIVERNAME"]);
    NSString *loadtons =NoNull([_data valueForKey:@"WEIGHT"]);
    NSString *unit =@"";
    NSString *start =@"";
    NSString *end =@"";
    NSString *sender =@"";
    NSString *receiver =@"";
    NSString *auditor =@"";
    NSString *backup = @"";
    

    
    //web
    //UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(o, -o, HEIGHT-o, WIDTH+o)];
    //[web loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    //[self.view addSubview:web];
    //img
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(o, 0, HEIGHT-o, WIDTH)];
    [img setImage:[UIImage imageNamed:@"test2d.png"]];
    [self.view addSubview:img];
    
    //2dcode
    UIImageView *code2d =[[UIImageView alloc]initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://218.92.115.55/mobileplatform/qrcode/qrcode.aspx?info=%@",_inGateNo]]]]];
    [code2d setFrame:CGRectMake(o+(HEIGHT-o)*16.38/20.19, 0, (HEIGHT-o)*3.76/20.19, WIDTH*3.25/9.47)];
    [self.view addSubview:code2d];
    
    //lb1 title
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(o, 0, (HEIGHT-o)*16.38/20.19, WIDTH*1.22/9.47)];
    [lb1 setText:[NSString stringWithFormat:@"江苏连云港港口股份有限公司%@港务分公司",department]];
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.adjustsFontSizeToFitWidth = YES;
    lb1.textColor =UURed;
    [self.view addSubview:lb1];
    //lb2 title2
    CGPoint i = lb1.frame.origin;
    CGSize j =lb1.frame.size;
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(o, j.height, (HEIGHT-o)*16.38/20.19, WIDTH*1.35/9.47)];
    [lb2 setText:@"发（收）货联单"];
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:lb2];
    
    //sender
    //lb3 sender1
    i = lb2.frame.origin;
    j =lb2.frame.size;
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(o, i.y+j.height, (HEIGHT-o)*2.33/20.19, WIDTH*1.3/9.47)];
    [lb3 setText:@"发货单位："];
    lb3.adjustsFontSizeToFitWidth = YES;
    lb3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb3];
    //lb4 sender2
    i = lb3.frame.origin;
    j =lb3.frame.size;
    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(o+j.width, i.y, (HEIGHT-o)*6.64/20.19, WIDTH*1.3/9.47)];
    [lb4 setText:company];
    lb4.adjustsFontSizeToFitWidth = YES;
    lb4.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb4];
    
    //task
    //lb5 taskno1
    i = lb4.frame.origin;
    j =lb4.frame.size;
    UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(j.width+i.x, i.y, (HEIGHT-o)*3.04/20.19, WIDTH*0.65/9.47)];
    [lb5 setText:@"委托号："];
    lb5.adjustsFontSizeToFitWidth = YES;
    lb5.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lb5];
    //lb6 taskno2
    i = lb5.frame.origin;
    j =lb5.frame.size;
    UILabel *lb6 = [[UILabel alloc]initWithFrame:CGRectMake(j.width+i.x, i.y, (HEIGHT-o)*4.42/20.19, WIDTH*0.65/9.47)];
    [lb6 setText:taskno];
    lb6.adjustsFontSizeToFitWidth = YES;
    lb6.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb6];
    
    //sendtime
    //lb7 sendtime
    i = lb5.frame.origin;
    j =lb5.frame.size;
    UILabel *lb7 = [[UILabel alloc]initWithFrame:CGRectMake(i.x, i.y+j.height, (HEIGHT-o)*3.04/20.19, WIDTH*0.65/9.47)];
    [lb7 setText:@"发货日期："];
    lb7.adjustsFontSizeToFitWidth = YES;
    lb7.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lb7];
    //lb8 sendtime1
    i = lb7.frame.origin;
    j =lb7.frame.size;
    UILabel *lb8 = [[UILabel alloc]initWithFrame:CGRectMake(j.width+i.x, i.y, (HEIGHT-o)*2.05/20.19, WIDTH*0.65/9.47)];
    [lb8 setText:[NSString stringWithFormat:@"%@年",sendtime1]];
    lb8.adjustsFontSizeToFitWidth = YES;
    lb8.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lb8];
    //lb9 sendtime2
    i = lb7.frame.origin;
    j =lb7.frame.size;
    UILabel *lb9 = [[UILabel alloc]initWithFrame:CGRectMake(j.width+i.x+(HEIGHT-o)*2.14/20.19, i.y, (HEIGHT-o)*2.14/20.19, WIDTH*0.65/9.47)];
    [lb9 setText:[NSString stringWithFormat:@"%@月",sendtime2]];
    lb9.adjustsFontSizeToFitWidth = YES;
    lb9.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lb9];
    //lb10 sendtime3
    i = lb7.frame.origin;
    j =lb7.frame.size;
    UILabel *lb10 = [[UILabel alloc]initWithFrame:CGRectMake(j.width+i.x+(HEIGHT-o)*2.14/20.19+(HEIGHT-o)*2.14/20.19, i.y, (HEIGHT-o)*2.14/20.19, WIDTH*0.65/9.47)];
    [lb10 setText:[NSString stringWithFormat:@"%@日",sendtime3]];
    lb10.adjustsFontSizeToFitWidth = YES;
    lb10.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lb10];
    
    //line3
    //cargo1
    i = lb3.frame.origin;
    j =lb3.frame.size;
    UILabel *lb11 = [[UILabel alloc]initWithFrame:CGRectMake(o, i.y+j.height, (HEIGHT-o)*3.41/20.19, WIDTH*0.74/9.47)];
    [lb11 setText:@"货名"];
    lb11.adjustsFontSizeToFitWidth = YES;
    lb11.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb11];
    //mark1
    i = lb11.frame.origin;
    j =lb11.frame.size;
    UILabel *lb12 = [[UILabel alloc]initWithFrame:CGRectMake(o+j.width, i.y, (HEIGHT-o)*2.67/20.19, WIDTH*0.74/9.47)];
    [lb12 setText:@"唛头"];
    lb12.adjustsFontSizeToFitWidth = YES;
    lb12.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb12];
    //ship1
    i = lb12.frame.origin;
    j =lb12.frame.size;
    UILabel *lb13 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*3.92/20.19, WIDTH*0.74/9.47)];
    [lb13 setText:@"船舶航次"];
    lb13.adjustsFontSizeToFitWidth = YES;
    lb13.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb13];
    //ticket
    i = lb13.frame.origin;
    j =lb13.frame.size;
    UILabel *lb14 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.03/20.19, WIDTH*0.74/9.47)];
    [lb14 setText:@"提单"];
    lb14.adjustsFontSizeToFitWidth = YES;
    lb14.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb14];
    //empty
    i = lb14.frame.origin;
    j =lb14.frame.size;
    UILabel *lb15 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.11/20.19, WIDTH*0.74/9.47)];
    [lb15 setText:@"空载"];
    lb15.adjustsFontSizeToFitWidth = YES;
    lb15.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb15];
    //loaded
    i = lb15.frame.origin;
    j =lb15.frame.size;
    UILabel *lb16 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.27/20.19, WIDTH*0.74/9.47)];
    [lb16 setText:@"重载"];
    lb16.adjustsFontSizeToFitWidth = YES;
    lb16.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb16];
    //tons
    i = lb16.frame.origin;
    j =lb16.frame.size;
    UILabel *lb17 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.01/20.19, WIDTH*0.74/9.47)];
    [lb17 setText:@"净吨"];
    lb17.adjustsFontSizeToFitWidth = YES;
    lb17.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb17];
    //number
    i = lb17.frame.origin;
    j =lb17.frame.size;
    UILabel *lb18 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*1.77/20.19, WIDTH*0.74/9.47)];
    [lb18 setText:@"件数"];
    lb18.adjustsFontSizeToFitWidth = YES;
    lb18.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb18];
    
    
    //line4
    //cargo2
    i = lb11.frame.origin;
    j =lb11.frame.size;
    UILabel *lb19 = [[UILabel alloc]initWithFrame:CGRectMake(o, i.y+j.height, (HEIGHT-o)*3.41/20.19, WIDTH*0.95/9.47)];
    [lb19 setText:cargo];
    lb19.adjustsFontSizeToFitWidth = YES;
    lb19.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb19];
    //mark1
    i = lb19.frame.origin;
    j =lb19.frame.size;
    UILabel *lb20 = [[UILabel alloc]initWithFrame:CGRectMake(o+j.width, i.y, (HEIGHT-o)*2.67/20.19, WIDTH*0.95/9.47)];
    [lb20 setText:mark];
    lb20.adjustsFontSizeToFitWidth = YES;
    lb20.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb20];
    //ship1
    i = lb20.frame.origin;
    j =lb20.frame.size;
    UILabel *lb21 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*3.92/20.19, WIDTH*0.95/9.47)];
    [lb21 setText:ship];
    lb21.adjustsFontSizeToFitWidth = YES;
    lb21.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb21];
    //ticket
    i = lb21.frame.origin;
    j =lb21.frame.size;
    UILabel *lb22 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.03/20.19, WIDTH*0.95/9.47)];
    [lb22 setText:ticket];
    lb22.adjustsFontSizeToFitWidth = YES;
    lb22.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb22];
    //empty
    i = lb22.frame.origin;
    j =lb22.frame.size;
    UILabel *lb23 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.11/20.19, WIDTH*0.95/9.47)];
    [lb23 setText:empty];
    lb23.adjustsFontSizeToFitWidth = YES;
    lb23.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb23];
    //loaded
    i = lb23.frame.origin;
    j =lb23.frame.size;
    UILabel *lb24 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.27/20.19, WIDTH*0.95/9.47)];
    [lb24 setText:loaded];
    lb24.adjustsFontSizeToFitWidth = YES;
    lb24.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb24];
    //tons
    i = lb24.frame.origin;
    j =lb24.frame.size;
    UILabel *lb25 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.01/20.19, WIDTH*0.95/9.47)];
    [lb25 setText:tons];
    lb25.adjustsFontSizeToFitWidth = YES;
    lb25.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb25];
    //number
    i = lb25.frame.origin;
    j =lb25.frame.size;
    UILabel *lb26 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*1.77/20.19, WIDTH*0.95/9.47)];
    [lb26 setText:number];
    lb26.adjustsFontSizeToFitWidth = YES;
    lb26.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb26];
    
    //line5
    //carno1
    i = lb19.frame.origin;
    j =lb19.frame.size;
    UILabel *lb27 = [[UILabel alloc]initWithFrame:CGRectMake(o, i.y+j.height, (HEIGHT-o)*3.41/20.19, WIDTH*0.95/9.47)];
    [lb27 setText:@"车号"];
    lb27.adjustsFontSizeToFitWidth = YES;
    lb27.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb27];
    //carno2
    i = lb27.frame.origin;
    j =lb27.frame.size;
    UILabel *lb28 = [[UILabel alloc]initWithFrame:CGRectMake(o+j.width, i.y, (HEIGHT-o)*2.67/20.19, WIDTH*0.95/9.47)];
    [lb28 setText:carno];
    lb28.adjustsFontSizeToFitWidth = YES;
    lb28.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb28];
    //driver1
    i = lb28.frame.origin;
    j =lb28.frame.size;
    UILabel *lb29 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*1.61/20.19, WIDTH*0.95/9.47)];
    [lb29 setText:@"司机"];
    lb29.adjustsFontSizeToFitWidth = YES;
    lb29.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb29];
    //driver2
    i = lb29.frame.origin;
    j =lb29.frame.size;
    UILabel *lb30 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.3/20.19, WIDTH*0.95/9.47)];
    [lb30 setText:driver];
    lb30.adjustsFontSizeToFitWidth = YES;
    lb30.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb30];
    //loadtons1
    i = lb30.frame.origin;
    j =lb30.frame.size;
    UILabel *lb31 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2/20.19, WIDTH*0.95/9.47)];
    [lb31 setText:@"配载吨数"];
    lb31.adjustsFontSizeToFitWidth = YES;
    lb31.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb31];
    //loadtons2
    i = lb31.frame.origin;
    j =lb31.frame.size;
    UILabel *lb32 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.08/20.19, WIDTH*0.95/9.47)];
    [lb32 setText:loadtons];
    lb32.adjustsFontSizeToFitWidth = YES;
    lb32.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb32];
    //unit1
    i = lb32.frame.origin;
    j =lb32.frame.size;
    UILabel *lb33 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.24/20.19, WIDTH*0.95/9.47)];
    [lb33 setText:@"运输单位"];
    lb33.adjustsFontSizeToFitWidth = YES;
    lb33.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb33];
    //unit2
    i = lb33.frame.origin;
    j =lb33.frame.size;
    UILabel *lb34 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*3.81/20.19, WIDTH*0.95/9.47)];
    [lb34 setText:unit];
    lb34.adjustsFontSizeToFitWidth = YES;
    lb34.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb34];
    
    //line6
    //start1
    i = lb27.frame.origin;
    j =lb27.frame.size;
    UILabel *lb35 = [[UILabel alloc]initWithFrame:CGRectMake(o, i.y+j.height, (HEIGHT-o)*3.41/20.19, WIDTH*2.2/9.47)];
    [lb35 setText:@"起运地"];
    lb35.adjustsFontSizeToFitWidth = YES;
    lb35.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb35];
    //start2
    i = lb35.frame.origin;
    j =lb35.frame.size;
    UILabel *lb36 = [[UILabel alloc]initWithFrame:CGRectMake(o+j.width, i.y, (HEIGHT-o)*2.67/20.19, WIDTH*2.2/9.47)];
    [lb36 setText:start];
    lb36.adjustsFontSizeToFitWidth = YES;
    lb36.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb36];
    //end1
    i = lb36.frame.origin;
    j =lb36.frame.size;
    UILabel *lb37 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*2.94/20.19, WIDTH*2.2/9.47)];
    [lb37 setText:@"到达地"];
    lb37.adjustsFontSizeToFitWidth = YES;
    lb37.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb37];
    //end2
    i = lb37.frame.origin;
    j =lb37.frame.size;
    UILabel *lb38 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*3.04/20.19, WIDTH*2.2/9.47)];
    [lb38 setText:end];
    lb38.adjustsFontSizeToFitWidth = YES;
    lb38.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb38];
    
    
    //sender1
    i = lb38.frame.origin;
    j =lb38.frame.size;
    UILabel *lb39 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*4.42/20.19, WIDTH*0.74/9.47)];
    [lb39 setText:@"发货人"];
    lb39.adjustsFontSizeToFitWidth = YES;
    lb39.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb39];
    //sender2
    i = lb39.frame.origin;
    j =lb39.frame.size;
    UILabel *lb40 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*3.81/20.19, WIDTH*0.74/9.47)];
    [lb40 setText:sender];
    lb40.adjustsFontSizeToFitWidth = YES;
    lb40.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb40];
    //recivier1
    i = lb39.frame.origin;
    j =lb39.frame.size;
    UILabel *lb41 = [[UILabel alloc]initWithFrame:CGRectMake(i.x, i.y+j.height, (HEIGHT-o)*4.42/20.19, WIDTH*0.74/9.47)];
    [lb41 setText:@"收货人"];
    lb41.adjustsFontSizeToFitWidth = YES;
    lb41.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb41];
    //recivier2
    i = lb41.frame.origin;
    j =lb41.frame.size;
    UILabel *lb42 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*3.81/20.19, WIDTH*0.74/9.47)];
    [lb42 setText:receiver];
    lb42.adjustsFontSizeToFitWidth = YES;
    lb42.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb42];
    //auditor1
    i = lb41.frame.origin;
    j =lb41.frame.size;
    UILabel *lb43 = [[UILabel alloc]initWithFrame:CGRectMake(i.x, i.y+j.height, (HEIGHT-o)*4.42/20.19, WIDTH*0.74/9.47)];
    [lb43 setText:@"理保员"];
    lb43.adjustsFontSizeToFitWidth = YES;
    lb43.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb43];
    //auditor2
    i = lb43.frame.origin;
    j =lb43.frame.size;
    UILabel *lb44 = [[UILabel alloc]initWithFrame:CGRectMake(i.x+j.width, i.y, (HEIGHT-o)*3.81/20.19, WIDTH*0.74/9.47)];
    [lb44 setText:auditor];
    lb44.adjustsFontSizeToFitWidth = YES;
    lb44.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb44];
    
    //line7
    //backup1
    i = lb35.frame.origin;
    j =lb35.frame.size;
    UILabel *lb45 = [[UILabel alloc]initWithFrame:CGRectMake(o, i.y+j.height, (HEIGHT-o)*3.41/20.19, WIDTH*0.74/9.47)];
    [lb45 setText:@"备注"];
    lb45.adjustsFontSizeToFitWidth = YES;
    lb45.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb45];
    //backup2
    i = lb45.frame.origin;
    j =lb45.frame.size;
    UILabel *lb46 = [[UILabel alloc]initWithFrame:CGRectMake(o+j.width, i.y, (HEIGHT-o)*16.5/20.19, WIDTH*0.74/9.47)];
    [lb46 setText:backup];
    lb46.adjustsFontSizeToFitWidth = YES;
    lb46.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb46];



    //
    self.view.backgroundColor = UUGrey;
    
    CGAffineTransform at =CGAffineTransformMakeRotation(M_PI/2);
    [self.view setTransform:at];

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
