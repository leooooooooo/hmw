//
//  ListTableViewController.m
//  hmw
//
//  Created by zhangchao on 15/11/16.
//  Copyright © 2015年 leo. All rights reserved.
//

#import "OldListTableViewController.h"
#import <Leo/Leo.h>
#import "Code_2DViewController.h"
@import Leo.Post;

@interface OldListTableViewController ()
@property(nonatomic,strong)UITextField *tel;
@property(nonatomic,strong)NSArray *list;
@end

@implementation OldListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tel = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2, 30)];
    [self.tel setPlaceholder:@"请输入手机号进行查询"];
    [self.tel setBackgroundColor:[UIColor whiteColor]];
    self.tel.layer.borderColor = [UIColor grayColor].CGColor;
    self.tel.layer.borderWidth = 1.0;
    self.tel.layer.cornerRadius = 5.0;
    [self.navigationItem setTitleView:self.tel];
    
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(selecttel)];
    [self.navigationItem setRightBarButtonItem:select];
}

-(void)selecttel
{
    self.list = [Post getSynchronousRequestDataJSONSerializationWithURL:@"http://www.boea.cn/m_hmw/business/czyy/olddeliverynote.aspx" withHTTPBody:[NSString stringWithFormat:@"tel=%@",self.tel.text]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        
        CGRect nameRect = CGRectMake(20,10, WIDTH, 30);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSUInteger row = [indexPath row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [NSString stringWithFormat:@"委托号：%@   关联号：%@",[[self.list objectAtIndex:row]objectAtIndex:1],[[self.list objectAtIndex:row]objectAtIndex:2]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *inGateNo = [[self.list objectAtIndex:indexPath.row]objectAtIndex:0];
    NSDictionary *CardInfo = [Post getSynchronousRequestDataJSONSerializationWithURL:@"http://218.92.115.55/M_Hmw/business/hyyy/GetVehAttestByNGATENO.aspx" withHTTPBody:[NSString stringWithFormat:@"inGateNo=%@",inGateNo]];
    
    Code_2DViewController *vc = [[Code_2DViewController alloc]init];
    vc.title = @"电子提送货单";
    vc.data = CardInfo;
    vc.inGateNo =[NSString stringWithFormat:@"inGateNo=%@",inGateNo];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
