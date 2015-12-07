//
//  HYTableViewController.m
//  iLygport
//
//  Created by leo on 15/2/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "HYTableViewController.h"
#import "Header.h"
#import "CompanySwitchViewController.h"
#import "SwitchOnlyViewController.h"
#import "CompanyOnlyViewController.h"
#import "EmptyViewController.h"
#import "InputOnlyViewController.h"
#import "Code_2DViewController.h"
#import <Leo/Leo.h>
@import Leo.Scan2DCodeViewController;
@import Leo.Navigation;
@import Leo.Web;
@import Leo.Post;
@import Leo.Table;

@interface HYTableViewController ()<Scan2DCodeDelegate>
@property (nonatomic,retain)Scan2DCodeViewController *Scan2DCode;
@property NSString *CardNo;
@property int whichScan;
@end

@implementation HYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KeychainItemWrapper *info =[[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle]autorelease];
    self.userID =[info objectForKey:(id)kSecAttrAccount];
    
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]autorelease];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    
    NSDictionary *tDic1 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"汽车衡重码单",@"name",@"ico0_10.png",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic2 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"网上申报未导入车队车辆",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic3 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"已导入车队车辆",@"name",@"ico0_10.png",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic4 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"新陆桥公司作业计划",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic5 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"已放行运输列表",@"name",@"ico0_10.png",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic6 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"已提交未放行运输列表",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic7 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"电子提送货单",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil]autorelease];

    
    
    self.teaArray = [[[NSArray alloc]initWithObjects:tDic1,tDic2,tDic3,tDic4,tDic5,tDic6,tDic7, nil]autorelease];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"货运应用";
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[self customCellByXib:tableView withIndexPath:indexPath];
    

    
    
    //default:assert(cell !=nil);
    //break;
    
    
    
    return cell;
}



//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

//通过nib文件自定义cell
-(UITableViewCell *)customCellByXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
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
    KeychainItemWrapper *info =[[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle]autorelease];
    if([[info objectForKey:(id)kSecAttrAccount] isEqualToString:@"0"]|[[info objectForKey:(id)kSecAttrAccount] isEqualToString:@""])
    {
        if (indexPath.row==6) {
            [self Code_2D];
            return;
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请先登录！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
    switch (indexPath.row) {
        case 0:
            [self VehicleBalance];
            break;
        case 1:
            [self VehicleDeclaration];
            break;
        case 2:
            [self VehicleRegistration];
            break;
        case 3:
            [self NewLandBridgeWorkPlan];
            break;
        case 4:
            [self PassedTransportation];
            break;
        case 5:
            [self NoPassedTransportation];
            break;
        case 6:
            [self Code_2D];
            break;
        default:
            break;
    }
    }
}



-(void)VehicleBalance
{
    CompanyOnlyViewController *asd =[self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"汽车衡量码单";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hdyy/VehicleBalance.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)VehicleDeclaration
{
    InputOnlyViewController *asd =[self.storyboard instantiateViewControllerWithIdentifier:@"InputOnly"];
    asd.userID = self.userID;
    asd.inputLabelName=@"车牌号";
    asd.title = @"网上申报未导入车队车辆";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hyyy/VehicleDeclaration.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)VehicleRegistration
{
    InputOnlyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"InputOnly"];
    asd.userID = self.userID;
    asd.inputLabelName=@"车牌号";
    asd.title = @"已导入车队车辆";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hyyy/VehicleRegistration.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)NewLandBridgeWorkPlan
{
    SwitchOnlyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"SwitchOnly"];
    asd.userID = self.userID;
    asd.title = @"新路桥公司作业计划";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hyyy/NewLandBridgeWorkPlan.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)PassedTransportation
{
    InputOnlyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"InputOnly"];
    asd.userID = self.userID;
    asd.inputLabelName=@"任务号";
    asd.title = @"已放行运输列表";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hyyy/PassedTransportation.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)NoPassedTransportation
{
    InputOnlyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"InputOnly"];
    asd.userID = self.userID;
    asd.inputLabelName=@"任务号";
    asd.title = @"已提交未放行运输列表";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hyyy/NoPassedTransportation.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)Code_2D
{
    if (_CardNo) {
        NSDictionary *CardInfo = [Post getSynchronousRequestDataJSONSerializationWithURL:@"http://218.92.115.55/M_Hmw/business/hyyy/GetVehAttestByNGATENO.aspx" withHTTPBody:[NSString stringWithFormat:@"inGateNo=%@",_CardNo]];
        
        Code_2DViewController *vc = [[Code_2DViewController alloc]init];
        vc.title = @"基本信息";
        vc.data = CardInfo;
        vc.inGateNo =[NSString stringWithFormat:@"inGateNo=%@",_CardNo];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        _whichScan = 1;
        [self scan];
    }
}

-(void)ScanButton
{
    _whichScan = 0;
    [self scan];
}

-(void)scan
{
    self.Scan2DCode = [[Scan2DCodeViewController alloc]init];
    self.Scan2DCode.Scan2DCodeDelegate = self;
    self.Scan2DCode.tip = @"请将摄像头对准港通卡上二维码扫描";
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
    
    if([Paser rangeOfString:@"inGateNo"].location!=NSNotFound)
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
        
        NSLog(@"%@",_CardNo);
        [self endScan];
    }
    else
    {
        UIViewController *vc = [Web BaseWeb:Paser];
        [self.navigationController pushViewController:vc animated:YES] ;
    }
}


-(void)endScan
{
    switch (_whichScan) {
        case 1:
            [self Code_2D];
            break;
            
        default:
            break;
    }
    
}




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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
