//
//  ViewController.m
//  RefreshLoadView
//
//  Created by chuliangliang on 14-6-12.
//  Copyright (c) 2014年 aikaola. All rights reserved.
//

#import "MessageViewController.h"
#import "AppDelegate.h"


#define WebService @"http://218.92.115.55/M_hmw/SERVICEHMW.ASMX"
#define SendName login
#define Result @"SelectMessageAbstractResult"
#define SoapName @"SelectMessageAbstract"
#define Token @"MV4FGbDeCY/c0E5Xh9k8Mg=="

#define key1 @"<UserId>%@</UserId>",da.userid
#define key2 @"<minRow>%d</minRow>",1
#define key3 @"<maxRow>%d</maxRow>",5
#define key4 @""
#define key5 @""
#define key6 @""
#define key7 @""
#define key8 @""


const int Max_Count = 5;
@interface MessageViewController ()
{
    int loadCount;
}
@property (nonatomic,strong)CLLRefreshHeadController *refreshControll;
@property (nonatomic)BOOL *isRecevied;
@end

@implementation MessageViewController

- (CLLRefreshHeadController *)refreshControll
{
    if (!_refreshControll) {
        _refreshControll = [[CLLRefreshHeadController alloc] initWithScrollView:self.tableView viewDelegate:self];
    }
    return _refreshControll;
}
#pragma mark-
#pragma mark- CLLRefreshHeadContorllerDelegate
- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnScrollViews;
}
- (BOOL)keepiOS7NewApiCharacter {
    
    if (!self.navigationController)
        return NO;
    BOOL keeped = [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
    return keeped;
}

- (void)beginPullDownRefreshing {
    soap *SendName=[[soap alloc]init];
    SendName.sendDelegate=self;
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    [SendName matchingElement:Result];
    // 创建SOAP消息，内容格式就是网站上提示的请求报文的实体主体部分

    AppDelegate *da=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    soapmsg= nil;
    soapmsg = [[NSMutableString alloc]init];
    [soapmsg appendFormat:soapmsg1];
    NSString *soapname = SoapName;
    NSString *token =Token;
    [soapmsg appendFormat:@"<%@ xmlns=\"http://tempuri.org/\">",soapname];
    [soapmsg appendFormat:@"<token>%@</token>",token];
    [soapmsg appendFormat:key1];
    [soapmsg appendFormat:key2];
    [soapmsg appendFormat:key3];
    [soapmsg appendFormat:key4];
    [soapmsg appendFormat:key5];
    [soapmsg appendFormat:key6];
    [soapmsg appendFormat:key7];
    [soapmsg appendFormat:key8];
    [soapmsg appendFormat:@"</%@>",soapname];
    [soapmsg appendFormat:soapmsg2];
    [SendName soapMsg:soapmsg];
    [SendName url:ServiceMobileApplication];
    [SendName send];
    self.isRecevied = YES;
}
- (void)beginPullUpLoading
{
    [self performSelector:@selector(endLoadMore) withObject:nil afterDelay:3];
}

-(void)returnxml:(NSString *)xml{
    parser *pp = [[parser alloc]init];
    pp.send=self;
    [pp nsxmlparser:xml];
    //pp = nil;
}

-(void)returnparser:(NSMutableArray *)parser{
    if ([[[parser objectAtIndex:0]objectAtIndex:0]isEqualToString:@"True"])
    {
        
        
    }
    if ([[[parser objectAtIndex:0]objectAtIndex:0]isEqualToString:@"False"]) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[[parser objectAtIndex:0]objectAtIndex:1] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }
    //NSLog([[parser objectAtIndex:0]objectAtIndex:0]);
    if (self.isRecevied) {
        [self performSelector:@selector(endRefresh) withObject:nil];
    }
    else
    {
        
    }
}

//是显示更多
- (BOOL)hasRefreshFooterView {
    if (self.arr.count > 0 && loadCount < Max_Count) {
        return YES;
    }
    return NO;
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.refreshControll startPullDownRefreshing];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    loadCount = 0;
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    self.navigationItem.title = @"设置";
    self.arr= [NSMutableArray array];
    
    ServiceMobileApplication =WebService;
    soapmsg1 = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
    "<soap12:Envelope "
    "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
    "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
    "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
    "<soap12:Body>";
    soapmsg2 = @"</soap12:Body>"
    "</soap12:Envelope>";
    soapmsg = [[NSMutableString alloc]init];
}

- (void)endRefresh {
    loadCount = 0;
    
    NSDictionary *tDic11 = [[NSDictionary alloc]initWithObjectsAndKeys:@"个人信息维护（未完成）",@"name",@"1.jpg",@"type",nil];
    NSDictionary *tDic21 = [[NSDictionary alloc]initWithObjectsAndKeys:@"修改密码（未完成）",@"name",@"1.jpg",@"type",nil];
    NSDictionary *tDic31 = [[NSDictionary alloc]initWithObjectsAndKeys:@"设备绑定",@"name",@"1.jpg",@"type",nil];
    NSDictionary *tDic41 = [[NSDictionary alloc]initWithObjectsAndKeys:@"检查更新",@"name",@"1.jpg",@"type",nil];
    NSDictionary *tDic51 = [[NSDictionary alloc]initWithObjectsAndKeys:@"史1强",@"name",@"1.jpg",@"type", @"C406", @"office",nil];
    NSDictionary *tDic61 = [[NSDictionary alloc]initWithObjectsAndKeys:@"李1",@"name",@"2.jpg",@"type", @"D011", @"office",nil];

    _stuArray = [[NSMutableArray alloc]initWithObjects:tDic11,tDic21,tDic31,tDic41,tDic51,tDic61, nil];
    self.arr = _stuArray;
    [self.tableView reloadData];
    
    [self.refreshControll endPullDownRefreshing];
}
- (void)endLoadMore {
    loadCount ++;
    //NSMutableArray *_stuArray = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"第%d次就加载更多,共%d次",loadCount,Max_Count ],@"更多1",@"更多2",@"更多3", nil];
    [self.arr addObjectsFromArray:_stuArray];
    [self.tableView reloadData];
    
    [self.refreshControll endPullUpLoading];
    
}


#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    NSString *strText = [self.arr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"cell %ld -- %@",(long)indexPath.row,strText];
    return cell;
     */
    UITableViewCell *cell =[[UITableViewCell alloc]init];
    cell = [self customCellByXib0:tableView withIndexPath:indexPath];
    return cell;
}

//通过nib文件自定义cell
-(UITableViewCell *)customCellByXib0:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"MessageXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:self options:nil];//加载nib文件
        if([nib count]>0){
            cell = _MessageCell;
        }
        else{
            assert(NO);//读取文件失败
        }
    }
    NSUInteger row = [indexPath row];
    NSDictionary *dic  = [_stuArray objectAtIndex:row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [dic objectForKey:@"name"];
    
    //类型
    ((UIImageView *)[cell.contentView viewWithTag:4]).image = [UIImage imageNamed:[dic objectForKey:@"type"]];
    
    //办公室
    //((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                    
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"signin"]animated:YES];
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

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    self.arr = nil;
    self.tableView = nil;
    self.refreshControll = nil;
}
@end
