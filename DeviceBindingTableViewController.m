//
//  DeviceBindingTableViewController.m
//  iLygport
//
//  Created by leo on 15/1/28.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "DeviceBindingTableViewController.h"
#import "AppDelegate.h"
#import "Header.h"


@interface DeviceBindingTableViewController ()

@end

@implementation DeviceBindingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    isbinding=[[KeychainItemWrapper alloc] initWithIdentifier:@"isbinding" accessGroup:Bundle];
    delegate.isbinding = [isbinding objectForKey:(id)kSecValueData];
    
    
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //NSUInteger row = [indexPath row];
    //定义新的cell
    //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
    UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"devicebinding"]autorelease];
    //名称
    UILabel *nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 25)]autorelease];
    nameLabel.text =@"设备绑定";
    
    [cell.contentView addSubview:nameLabel];
    //按钮
    UISwitch *isbinding = [[[UISwitch alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-80, 7, 50, 25)]autorelease];
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([delegate.isbinding isEqual:@"1"])
    {
        [isbinding setOn:YES];
    }
    else
    {
        [isbinding setOn:NO];
    }
    [isbinding addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:isbinding];

    return cell;
}

-(void)switchAction:(id)sender
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    info = [[KeychainItemWrapper alloc]initWithIdentifier:@"info" accessGroup:Bundle];
    isbinding=[[KeychainItemWrapper alloc] initWithIdentifier:@"isbinding" accessGroup:Bundle];
    NSString *userid = [info objectForKey:(id)kSecAttrAccount];
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    NSString *rcc;
    if (isButtonOn) {
        NSString *url = [NSString stringWithFormat:@"http://218.92.115.55/M_hmw/getservice/devicebinding.aspx?usercode=%@&deviceToken=%@&DeviceType=iOS&isbinding=yes",userid,delegate.deviceToken];
        NSURL *get=[NSURL URLWithString:url];
        NSMutableURLRequest *rq=[NSMutableURLRequest requestWithURL:get];
        NSDate *rc =[NSURLConnection sendSynchronousRequest:rq returningResponse:nil error:nil];
        rcc=[[[NSString alloc]initWithData:rc encoding:NSUTF8StringEncoding]autorelease];
        delegate.isbinding =@"1";
        [isbinding setObject: @"1" forKey:(id)kSecValueData];
        //[status setObject:@"1" forKey:(id)kSecAttrAccount];
        NSLog(rcc);
    }else {
        NSString *url = [NSString stringWithFormat:@"http://218.92.115.55/M_hmw/getservice/devicebinding.aspx?usercode=%@&deviceToken=%@&DeviceType=iOS&isbinding=no",userid,delegate.deviceToken];
        NSURL *get=[NSURL URLWithString:url];
        NSMutableURLRequest *rq=[NSMutableURLRequest requestWithURL:get];
        NSDate *rc =[NSURLConnection sendSynchronousRequest:rq returningResponse:nil error:nil];
        rcc=[[[NSString alloc]initWithData:rc encoding:NSUTF8StringEncoding]autorelease];
        delegate.isbinding =@"0";
        [isbinding setObject: @"0" forKey:(id)kSecValueData];
        NSLog(rcc);
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"设备绑定" message:rcc delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


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
