//
//  PortCardFunctionListTableViewController.m
//  hmw
//
//  Created by zhangchao on 15/11/17.
//  Copyright © 2015年 leo. All rights reserved.
//

#import "PortCardFunctionListTableViewController.h"
#import <Leo/Leo.h>
#import "Header.h"

@interface PortCardFunctionListTableViewController ()

@end

@implementation PortCardFunctionListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Navigation NavigationConifigInitialize:self setNavigationBackArrowColor:NavigationBackArrowColor setNavigationBarColor:NavigationBarColor setNavigationTitleColor:NavigationTitleColor];
    
    
    NSDictionary *tDic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"基本信息",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil];
    NSDictionary *tDic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"运输申报",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil];
    NSDictionary *tDic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"港区通行",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil];
    NSDictionary *tDic4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"过磅记录",@"name",@"ico0_10.png",@"type", @"D011", @"office",nil];
    
    self.teaArray = [[NSArray alloc]initWithObjects:tDic1,tDic2,tDic3,tDic4,nil];
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
        CGRect nameRect = CGRectMake(i.x+j.width+10, i.y+13, self.view.bounds.size.width/1.5, 10);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
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
            [self CardBaseInfo];
            break;
        case 1:
            [self TransportApply];
            break;
        case 2:
            [self PortPass];
            break;
        case 3:
            [self WeighingRecord];
            break;
        default:
            break;
    }
    
}

-(void)CardBaseInfo
{
    if (_CardNo) {
        NSDictionary *CardInfo = [Post getSynchronousRequestDataJSONSerializationWithURL:@"http://218.92.115.55/M_Hmw/GetService/Scan/GetBasicInfo.aspx" withHTTPBody:[NSString stringWithFormat:@"No=%d&RecognizeMethod=QR",_CardNo]];
        
        UIViewController *vc = [Table DetailTable:CardInfo];
        vc.title = @"基本信息";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {

    }
    
}

-(void)TransportApply
{
    if (_CardNo) {
        NSDictionary *CardInfo = [Post getSynchronousRequestDataJSONSerializationWithURL:@"http://218.92.115.55/M_Hmw/GetService/Scan/GetTransportDeclare.aspx" withHTTPBody:[NSString stringWithFormat:@"No=%d&RecognizeMethod=QR",_CardNo]];
        
        UIViewController *vc = [Table DetailTable:CardInfo];
        vc.title = @"运输申报";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {

    }
}

-(void)PortPass
{
    if (_CardNo) {
        NSDictionary *CardInfo = [Post getSynchronousRequestDataJSONSerializationWithURL:@"http://218.92.115.55/M_Hmw/GetService/Scan/GetHarbourPass.aspx" withHTTPBody:[NSString stringWithFormat:@"No=%d&RecognizeMethod=QR",_CardNo]];
        
        UIViewController *vc = [Table DetailTable:CardInfo];
        vc.title = @"港区通行";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {

    }
}

-(void)WeighingRecord
{
    if (_CardNo) {
        NSDictionary *CardInfo = [Post getSynchronousRequestDataJSONSerializationWithURL:@"http://218.92.115.55/M_Hmw/GetService/Scan/GetWeighRecord.aspx" withHTTPBody:[NSString stringWithFormat:@"No=%d&RecognizeMethod=QR",_CardNo]];
        
        UIViewController *vc = [Table DetailTable:CardInfo];
        vc.title = @"过磅记录";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {

    }
}

@end
