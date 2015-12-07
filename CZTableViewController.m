//
//  CZTableViewController.m
//  iLygport
//
//  Created by leo on 15/2/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "CZTableViewController.h"
#import "Header.h"
#import "CompanySwitchViewController.h"
#import "SwitchOnlyViewController.h"
#import "CompanyOnlyViewController.h"
#import "EmptyViewController.h"
#import "InputOnlyViewController.h"
#import "Code_2DViewController.h"
#import "ListTableViewController.h"
#import "OldListTableViewController.h"
#import "PortCardFunctionListTableViewController.h"
#import <Leo/Leo.h>
@import Leo.Scan2DCodeViewController;
@import Leo.Navigation;
@import Leo.Web;
@import Leo.Post;
@import Leo.Table;

//#import "Scan2DCodeViewController.h"

@interface CZTableViewController ()<Scan2DCodeDelegate>
@property (nonatomic,retain)Scan2DCodeViewController *Scan2DCode;
@property(nonatomic,strong)NSString *CardNo;
@property int whichScan;
@property(nonatomic,strong)NSDictionary *CardInfo;
@property (nonatomic,retain)UIBarButtonItem *Info;
@end

@implementation CZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Navigation NavigationConifigInitialize:self setNavigationBackArrowColor:NavigationBackArrowColor setNavigationBarColor:NavigationBarColor setNavigationTitleColor:NavigationTitleColor];
    

    NSDictionary *tDic1 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"当前电子提送货单",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic2 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"历史电子提送货单",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil]autorelease];

    
    self.teaArray = [[[NSArray alloc]initWithObjects:tDic1,tDic2,nil]autorelease];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"司机应用";
    
    
    UIBarButtonItem *scan = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"simple2D.png"] style:UIBarButtonItemStylePlain target:self action:@selector(scan)];
    _Info = [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(CardBaseInfo)];
    NSArray *bar = [[NSArray alloc]initWithObjects:scan,_Info, nil];
    [self.navigationItem setRightBarButtonItems:bar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.teaArray.count;
}



//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

//通过nib文件自定义cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier]autorelease];
        
        //头像
        CGRect imageRect = CGRectMake(8, 5, 35, 35);
        UIImageView *imageView = [[[UIImageView alloc]initWithFrame:imageRect]autorelease];
        imageView.tag = 2;
        
        //为图片添加边框
        CALayer *layer = [imageView layer];
        layer.cornerRadius = 8;
        layer.borderColor = [[UIColor whiteColor]CGColor];
        layer.borderWidth = 1;
        layer.masksToBounds = YES;
        [cell.contentView addSubview:imageView];
        
        //发送者
        CGPoint i =imageRect.origin;
        CGSize j = imageRect.size;
        CGRect nameRect = CGRectMake(i.x+j.width+10, i.y+13, self.view.bounds.size.width/1.5, 10);
        UILabel *nameLabel = [[[UILabel alloc]initWithFrame:nameRect]autorelease];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSUInteger row = [indexPath row];
    NSDictionary *dic  = [self.teaArray objectAtIndex:row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [dic objectForKey:@"name"];
    
    //图标
    ((UIImageView *)[cell.contentView viewWithTag:2]).image = [UIImage imageNamed:[dic objectForKey:@"type"]];
    
    //办公室
    //((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self DeliveryNoteList];
            break;
        case 1:
            [self OldDeliveryNoteList];
            break;
        default:
            break;
        }
    
}

//当前电子提送货单
-(void)DeliveryNoteList
{
    ListTableViewController *list = [[ListTableViewController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}

//历史电子提送货单
-(void)OldDeliveryNoteList
{
    OldListTableViewController *list = [[OldListTableViewController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}


-(void)scan
{
    self.Scan2DCode = [[Scan2DCodeViewController alloc]init];
    self.Scan2DCode.Scan2DCodeDelegate = self;
    self.Scan2DCode.tip = @"请将摄像头对二维码扫描";
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 50, 20)];
    [back setTitle:@"取消" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.Scan2DCode.view addSubview:back];
    [self presentViewController:self.Scan2DCode animated:YES completion:nil];
}

-(void)back
{
    [self.Scan2DCode dismissViewControllerAnimated:YES completion:nil];
}

-(void)Paser2DCode:(NSString *)Paser
{
    NSLog(Paser,nil);
    [self back];
    
    if([Paser rangeOfString:@"CardTask"].location!=NSNotFound)
    {
        NSArray *sp = [Paser componentsSeparatedByString:@"="];
        _CardNo = [sp objectAtIndex:1];
        NSLog(@"%@",_CardNo);
        //[_Info setTitle:[NSString stringWithFormat:@"港通卡：%d",_CardNo]];
        PortCardFunctionListTableViewController *port = [[PortCardFunctionListTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:port animated:YES];
        
    }
    else if([Paser rangeOfString:@"inGateNo"].location!=NSNotFound)
    {
        NSArray *sp = [Paser componentsSeparatedByString:@"inGateNo="];
        
        NSString *EncryptWord =[sp objectAtIndex:1];
        
        
        NSURL *url = [NSURL URLWithString:@"http://boea.cn/MobilePlatform/Encryption/Des_Decrypt.aspx"];
        //2建立请求NSMutableURLRequest（post需要用这个）
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //网络访问超时时间
        [request setTimeoutInterval:20.0f];
        //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
        [request setHTTPMethod:@"POST"];
        //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
        //NSString *bodyStr = [NSString stringWithFormat:@"username=%@&password=%@", self.ID.text, self.PW.text];
        //将nstring转换成nsdata
        NSData *body = [[NSString stringWithFormat:@"Key=gljsy&Value=%@",EncryptWord] dataUsingEncoding:NSUTF8StringEncoding];
        //NSLog(@"body data %@", body);
        [request setHTTPBody:body];
        
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        _CardNo =[[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
        
        
        //_CardNo = EncryptWord;
        
        NSLog(@"%@",_CardNo);
        
        _CardInfo = [Post getSynchronousRequestDataJSONSerializationWithURL:@"http://218.92.115.55/M_Hmw/business/hyyy/GetVehAttestByNGATENO.aspx" withHTTPBody:[NSString stringWithFormat:@"inGateNo=%@",_CardNo]];
        
        Code_2DViewController *vc = [[Code_2DViewController alloc]init];
        vc.title = @"电子提送货单";
        vc.data = _CardInfo;
        vc.inGateNo =[NSString stringWithFormat:@"inGateNo=%@",_CardNo];
        dispatch_async(dispatch_get_main_queue(), ^{
                   [self.navigationController pushViewController:vc animated:YES];
        });


    }
    else
    {
        UIViewController *vc = [Web BaseWeb:Paser];
        [self.navigationController pushViewController:vc animated:YES] ;
    }
    
}

-(void)CODE2D
{

}



#pragma 不用管的东西

-(void)viewDidAppear:(BOOL)animated{
    [self hideTabBar];
    [super viewDidAppear:animated];
    //[self showTabBar];
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

@end
