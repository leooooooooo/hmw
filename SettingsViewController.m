//
//  SettingsViewController.m
//  SettingsExample
//
//  Created by Jake Marsh on 10/8/11.
//  Copyright (c) 2011 Rubber Duck Software. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "DeviceBindingTableViewController.h"
#import "Header.h"
#import "updateViewController.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize stuArray = _stuArray;
@synthesize teaArray = _teaArray;
@synthesize teaCell = _teaCell;

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    
    NSDictionary *tDic11 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"个人信息维护（未完成）",@"name",@"1.jpg",@"type",nil]autorelease];
    NSDictionary *tDic21 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"修改密码（未完成）",@"name",@"1.jpg",@"type",nil]autorelease];
    NSDictionary *tDic31 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"设备绑定",@"name",@"1.jpg",@"type",nil]autorelease];
    NSDictionary *tDic41 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"检查更新",@"name",@"1.jpg",@"type",nil]autorelease];
    NSDictionary *tDic51 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"史1强",@"name",@"1.jpg",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic61 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"李1",@"name",@"2.jpg",@"type", @"D011", @"office",nil]autorelease];
    _stuArray= [[[NSArray alloc]initWithObjects:tDic11,tDic21,tDic31,tDic41,tDic51,tDic61, nil]autorelease];
    
    //初始化老师数据
    NSDictionary *tDic1 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"重新登录",@"name",@"1.jpg",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic2 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"注销",@"name",@"2.jpg",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic3 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"史小强",@"name",@"1.jpg",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic4 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"李永乐",@"name",@"2.jpg",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic5 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"史小强",@"name",@"1.jpg",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic6 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"李永乐",@"name",@"2.jpg",@"type", @"D011", @"office",nil]autorelease];
    
    _teaArray = [[[NSArray alloc]initWithObjects:tDic1,tDic2,tDic3,tDic4,tDic5,tDic6, nil]autorelease];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"设置";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 2:
                    [self devicebinding];
                    break;

                case 3:
                    [self checkupdate];
                    break;
                default:
                    break;
            }
        }
            break;
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    [self login];
                    break;

                case 1:
                    [self logout];
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 4;
            break;
            
        case 1:
            return 2;
            break;
            
        default: return 0;
            break;
    }
    //return section == 1?[_stuArray count]:5;
}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//定义分区的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section == 1?@"":@"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[[UITableViewCell alloc]init]autorelease];
    switch ([indexPath section]) {
        case 0:
            //通过nib自定义cell
            cell = [self customCellByXib0:tableView withIndexPath:indexPath];
            break;
        case 1:
            //通过nib自定义cell
            cell = [self customCellByXib1:tableView withIndexPath:indexPath];
            break;
        
        //default:assert(cell !=nil);
            //break;
    }
    

    return cell;
}

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


//通过nib文件自定义cell
-(UITableViewCell *)customCellByXib0:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];//加载nib文件
        if([nib count]>0){
            cell = _teaCell;
        }
        else{
            assert(NO);//读取文件失败
        }
    }
    NSUInteger row = [indexPath row];
    NSDictionary *dic  = [_stuArray objectAtIndex:row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:teaNameTag]).text = [dic objectForKey:@"name"];
    
    //类型
    ((UIImageView *)[cell.contentView viewWithTag:teaTypeTag]).image = [UIImage imageNamed:[dic objectForKey:@"type"]];
    
    //办公室
    //((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];
    return cell;
}

//通过nib文件自定义cell
-(UITableViewCell *)customCellByXib1:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];//加载nib文件
        if([nib count]>0){
            cell = _teaCell;
        }
        else{
            assert(NO);//读取文件失败
        }
    }
    NSUInteger row = [indexPath row];
    NSDictionary *dic  = [_teaArray objectAtIndex:row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:teaNameTag]).text = [dic objectForKey:@"name"];
    
    //类型
    ((UIImageView *)[cell.contentView viewWithTag:teaTypeTag]).image = [UIImage imageNamed:[dic objectForKey:@"type"]];
    
    //办公室
    //((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];
    return cell;
}

-(void)login
{
    status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    [status setObject:@"0" forKey:(id)kSecValueData];
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"signin"]animated:YES];
}

-(void)logout
{
    status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    userid = [info objectForKey:(id)kSecAttrAccount];
    [status setObject:@"0" forKey:(id)kSecValueData];
    [info setObject:@"0" forKey:(id)kSecAttrAccount];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注销成功！" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [self performSegueWithIdentifier:@"logout" sender:self];
}

-(void)devicebinding
{
    info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    if([[info objectForKey:(id)kSecAttrAccount] isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请先登录" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
    DeviceBindingTableViewController *devicebinding =  [self.storyboard instantiateViewControllerWithIdentifier:@"devicebinding"];
    
    devicebinding.navigationItem.title = @"设备绑定";
    [devicebinding.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:UITextAttributeTextColor];
    devicebinding.navigationController.navigationBar.titleTextAttributes=dict;
    [self.navigationController pushViewController:devicebinding animated:YES];
    }
}
-(void)checkupdate
{
    NSString *url = [NSString stringWithFormat:@"http://218.92.115.55/M_hmw/getservice/HMWUPDATE.ASPX?deviceType=iOS&version=%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    NSURL *get=[NSURL URLWithString:url];
    NSMutableURLRequest *rq=[NSMutableURLRequest requestWithURL:get];
    NSDate *rc =[NSURLConnection sendSynchronousRequest:rq returningResponse:nil error:nil];
    NSString *rcc=[[[NSString alloc]initWithData:rc encoding:NSUTF8StringEncoding]autorelease];
    NSString *pb;
    UIAlertView *alert;
    if([rcc isEqualToString:@"yes"]|[rcc isEqualToString:@"yes\r\n"])
    {
        pb = [NSString stringWithFormat:@"当前版本为%@，已经是最新版本",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        alert = [[UIAlertView alloc]initWithTitle:@"版本更新" message:pb delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        pb = [NSString stringWithFormat:@"检测到最新版本%@，请更新",rcc];
        alert = [[UIAlertView alloc]initWithTitle:@"版本更新" message:pb delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [self update];
    }
    
}
-(void)update{

    NSString *url = [NSString stringWithFormat:@"http://218.92.115.55/wlkgbsgsapp/install/install.html"];
            updateViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"updatewebview"];
    asd.url = url;
    
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil]autorelease];
    [self.navigationItem setBackBarButtonItem:backButton];
    [asd.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)dealloc
{
    [super dealloc];
}

@end