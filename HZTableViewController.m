//
//  HZTableViewController.m
//  iLygport
//
//  Created by leo on 15/2/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "HZTableViewController.h"
#import "Header.h"
#import "CompanySwitchViewController.h"
#import "SwitchOnlyViewController.h"
#import "CompanyOnlyViewController.h"
#import "EmptyViewController.h"
@interface HZTableViewController ()

@end

@implementation HZTableViewController

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
    //NSDictionary *tDic1 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"货源管理",@"name",@"ico0_09.png",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic2 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"货物进港动态",@"name",@"ico0_09.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic3 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"货物出港动态",@"name",@"ico0_09.png",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic4 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"货物兑动态",@"name",@"ico0_09.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic5 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"货物港内结存信息",@"name",@"ico0_09.png",@"type", @"C406", @"office",nil]autorelease];
    NSDictionary *tDic6 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"船舶确报信息",@"name",@"ico0_09.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic7 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"锚地船舶",@"name",@"ico0_09.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic8 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"泊位船舶",@"name",@"ico0_09.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic9 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"已做计划船舶信息列表",@"name",@"ico0_09.png",@"type", @"D011", @"office",nil]autorelease];
    NSDictionary *tDic10 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"需要移泊船舶信息列表",@"name",@"ico0_09.png",@"type", @"D011", @"office",nil]autorelease];
    
    
    self.teaArray = [[[NSArray alloc]initWithObjects:tDic2,tDic3,tDic4,tDic5,tDic6,tDic7,tDic8,tDic9,tDic10, nil]autorelease];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"货主应用";
    
    
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
    return 9;
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请先登录！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
    switch (indexPath.row) {
        case 0:
            [self CargoIn];
            break;
        case 1:
            [self CargoOut];
            break;
        case 2:
            [self CargoDui];
            break;
        case 3:
            [self CargoBalance];
            break;
        case 4:
            [self IndeedShip];
            break;
        case 5:
            [self AnchorShip];
            break;
        case 6:
            [self BerthShip];
            break;
        case 7:
            [self PlanedShip];
            break;
        case 8:
            [self MoveShip];
            break;
        default:
            break;
    }
    }
}

-(void)CargoIn
{
    EmptyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"货物进港动态信息";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hzyy/CargoIn.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)CargoOut
{
    EmptyViewController *asd =[self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"货物出港动态信息";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hzyy/CargoOut.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)CargoDui
{
    EmptyViewController *asd =[self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"货物兑动态信息";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hzyy/CargoDui.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)CargoBalance
{
    EmptyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"货物港内结存信息";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/hzyy/CargoBalance.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)IndeedShip
{
    EmptyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"船舶确报信息";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/cdyy/IndeedShip.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)AnchorShip
{
    EmptyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"锚地船舶";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/cdyy/AnchorShip.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)BerthShip
{
    EmptyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"泊位船舶";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/cdyy/BerthShip.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)PlanedShip
{
    EmptyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"已做计划船舶信息列表";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/cdyy/PlanedShip.html";
    [self.navigationController pushViewController:asd animated:YES];
}

-(void)MoveShip
{
    EmptyViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"Empty"];
    asd.userID = self.userID;
    asd.title = @"需要移泊船舶信息列表";
    asd.url =@"http://218.92.115.55/M_Hmw/Business/cdyy/MoveShip.html";
    [self.navigationController pushViewController:asd animated:YES];
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
