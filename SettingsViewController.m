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
#import "changePasswordViewController.h"
#import "changeInfoViewController.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController


- (void)viewDidLoad
{
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil]autorelease];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.77 green:0.00 blue:0.05 alpha:1]];
    NSDictionary *tDic11 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"个人信息维护",@"name",@"1.jpg",@"type",nil]autorelease];
    NSDictionary *tDic21 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"修改密码",@"name",@"1.jpg",@"type",nil]autorelease];
    NSDictionary *tDic31 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"设备绑定",@"name",@"1.jpg",@"type",nil]autorelease];
    NSDictionary *tDic41 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"检查更新",@"name",@"1.jpg",@"type",nil]autorelease];
    NSDictionary *tDic51 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"史1强",@"name",@"1.jpg",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic61 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"李1",@"name",@"2.jpg",@"type", @"D011", @"office",nil]autorelease];
    self.stuArray= [[[NSArray alloc]initWithObjects:tDic11,tDic21,tDic31,tDic41,tDic51,tDic61, nil]autorelease];
    
    //初始化老师数据
    NSDictionary *tDic1 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"登录",@"name",@"1.jpg",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic2 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"注销",@"name",@"2.jpg",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic3 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"史小强",@"name",@"1.jpg",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic4 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"李永乐",@"name",@"2.jpg",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic5 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"史小强",@"name",@"1.jpg",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic6 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"李永乐",@"name",@"2.jpg",@"type", @"D011", @"office",nil]autorelease];
    
    self.teaArray = [[[NSArray alloc]initWithObjects:tDic1,tDic2,tDic3,tDic4,tDic5,tDic6, nil]autorelease];
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
                case 0:
                    [self changeinfo];
                    break;
                case 1:
                    [self changePassword];
                    break;

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
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //头像
        CGRect imageRect = CGRectMake(8, 5, 35, 35);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
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
        CGRect nameRect = CGRectMake(i.x+j.width+10, i.y+13, self.view.bounds.size.width/2, 10);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        
    }

    NSUInteger row = [indexPath row];
    NSDictionary *dic  = [self.stuArray objectAtIndex:row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [dic objectForKey:@"name"];
    
    //图标
    ((UIImageView *)[cell.contentView viewWithTag:2]).image = [UIImage imageNamed:[dic objectForKey:@"type"]];
    
    //办公室
    //((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];
    return cell;
}

//通过nib文件自定义cell
-(UITableViewCell *)customCellByXib1:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //头像
        CGRect imageRect = CGRectMake(8, 5, 35, 35);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
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
        CGRect nameRect = CGRectMake(i.x+j.width+10, i.y+13, self.view.bounds.size.width/2, 10);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        
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

-(void)login
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    
    [backButton release];
    //status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    [status setObject:@"0" forKey:(id)kSecValueData];
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"signin"]animated:YES];
}


-(void)logout
{
    //status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    userid = [info objectForKey:(id)kSecAttrAccount];
    [status setObject:@"0" forKey:(id)kSecValueData];
    [info setObject:@"0" forKey:(id)kSecAttrAccount];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注销成功！" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [self performSegueWithIdentifier:@"logout" sender:self];
}

-(void)changeinfo
{
    info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    if([[info objectForKey:(id)kSecAttrAccount] isEqualToString:@"0"]|[[info objectForKey:(id)kSecAttrAccount] isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"个人信息维护" message:@"请先登录！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        changeInfoViewController *devicebinding =  [self.storyboard instantiateViewControllerWithIdentifier:@"changeinfo"];
        
        devicebinding.navigationItem.title = @"个人信息维护";
        [devicebinding.navigationController.navigationBar setBarTintColor:NavigationBarColor];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:UITextAttributeTextColor];
        devicebinding.navigationController.navigationBar.titleTextAttributes=dict;
        [self.navigationController pushViewController:devicebinding animated:YES];
    }

}

-(void)changePassword
{
    info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    if([[info objectForKey:(id)kSecAttrAccount] isEqualToString:@"0"]|[[info objectForKey:(id)kSecAttrAccount] isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"修改密码" message:@"请先登录！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        changePasswordViewController *devicebinding =  [self.storyboard instantiateViewControllerWithIdentifier:@"changepassword"];
        
        devicebinding.navigationItem.title = @"修改密码";
        [devicebinding.navigationController.navigationBar setBarTintColor:NavigationBarColor];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:UITextAttributeTextColor];
        devicebinding.navigationController.navigationBar.titleTextAttributes=dict;
        [self.navigationController pushViewController:devicebinding animated:YES];
    }
}

-(void)devicebinding
{
    info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    if([[info objectForKey:(id)kSecAttrAccount] isEqualToString:@"0"]|[[info objectForKey:(id)kSecAttrAccount] isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"设备绑定" message:@"请先登录！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
        NSString *url = [NSString stringWithFormat:@"http://218.92.115.55/wlkgbsgsapp/install/install.html"];
        updateViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"updatewebview"];
        asd.url = url;
        
        UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil]autorelease];
        [self.navigationItem setBackBarButtonItem:backButton];
        [asd.navigationItem setBackBarButtonItem:backButton];
        [self.navigationController pushViewController:asd animated:YES];

    }
    
}


-(void)dealloc
{
    [super dealloc];
}

@end