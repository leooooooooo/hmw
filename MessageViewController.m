//
//  ViewController.m
//  RefreshLoadView
//
//  Created by chuliangliang on 14-6-12.
//  Copyright (c) 2014年 aikaola. All rights reserved.
//

#import "MessageViewController.h"
#import "AppDelegate.h"
#import "MessageDetailViewController.h"
#import "SWTableViewCell.h"

#define WebService @"http://218.92.115.55/M_hmw/SERVICEHMW.ASMX"
#define SendName login
#define Result @"SelectMessageAbstractResult"
#define SoapName @"SelectMessageAbstract"
#define Token @"MV4FGbDeCY/c0E5Xh9k8Mg=="

#define key1 @"<UserId>%@</UserId>",da.userid
#define key2 @""
#define key3 @""
#define key4 @""
#define key5 @""
#define key6 @""
#define key7 @""
#define key8 @""



@interface MessageViewController ()
{
    int loadCount;
    int Max_Count;
}
@property (nonatomic,strong)CLLRefreshHeadController *refreshControll;
@property (nonatomic)BOOL isRecevied;
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
    Max_Count = 100;
    loadCount = 0;
    //self.arr = [[NSMutableArray alloc]init];
    //self.msgArray = [[NSMutableArray alloc]init];
    soap *SendName=[[soap alloc]init];
    SendName.sendDelegate=self;
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    [SendName matchingElement:Result];
    // 创建SOAP消息，内容格式就是网站上提示的请求报文的实体主体部分

    AppDelegate *da=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    soapmsg= nil;
    soapmsg = [[NSMutableString alloc]init];
    [soapmsg appendFormat:soapmsg1,nil];
    NSString *soapname = SoapName;
    NSString *token =Token;
    [soapmsg appendFormat:@"<%@ xmlns=\"http://tempuri.org/\">",soapname];
    [soapmsg appendFormat:@"<token>%@</token>",token];
    [soapmsg appendFormat:key1];
    [soapmsg appendFormat:@"<minRow>%d</minRow>",1];
    [soapmsg appendFormat:@"<maxRow>%d</maxRow>",10];
    [soapmsg appendFormat:key4];
    [soapmsg appendFormat:key5];
    [soapmsg appendFormat:key6];
    [soapmsg appendFormat:key7];
    [soapmsg appendFormat:key8];
    [soapmsg appendFormat:@"</%@>",soapname];
    [soapmsg appendFormat:soapmsg2,nil];
    [SendName soapMsg:soapmsg];
    [SendName url:ServiceMobileApplication];
    [SendName send];
    self.isRecevied = YES;
}
- (void)beginPullUpLoading
{
    NSLog(@"%d",loadCount);
    soap *SendName=[[soap alloc]init];
    SendName.sendDelegate=self;
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    [SendName matchingElement:Result];
    // 创建SOAP消息，内容格式就是网站上提示的请求报文的实体主体部分
    
    AppDelegate *da=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    soapmsg= nil;
    soapmsg = [[NSMutableString alloc]init];
    [soapmsg appendFormat:soapmsg1,nil];
    NSString *soapname = SoapName;
    NSString *token =Token;
    [soapmsg appendFormat:@"<%@ xmlns=\"http://tempuri.org/\">",soapname];
    [soapmsg appendFormat:@"<token>%@</token>",token];
    [soapmsg appendFormat:key1];
    [soapmsg appendFormat:@"<minRow>%d</minRow>",loadCount*10+0];
    [soapmsg appendFormat:@"<maxRow>%d</maxRow>",loadCount*10+9];
    [soapmsg appendFormat:key4];
    [soapmsg appendFormat:key5];
    [soapmsg appendFormat:key6];
    [soapmsg appendFormat:key7];
    [soapmsg appendFormat:key8];
    [soapmsg appendFormat:@"</%@>",soapname];
    [soapmsg appendFormat:soapmsg2,nil];
    [SendName soapMsg:soapmsg];
    [SendName url:ServiceMobileApplication];
    [SendName send];
    self.isRecevied = NO;
    
}

-(void)returnxml:(NSString *)xml{
    parser *pp = [[parser alloc]init];
    pp.send=self;
    [pp nsxmlparser:xml];
    //pp = nil;
}

-(void)returnparser:(NSMutableArray *)parser{
    if(loadCount==0)
    {
        self.msgArray = nil;
        self.msgArray = [[NSMutableArray alloc]init];
    }
    
    if ([[[parser objectAtIndex:0]objectAtIndex:0]isEqualToString:@"True"])
    {
        [parser removeObjectAtIndex:0];
        if(parser.count<10)
        {
            Max_Count = loadCount;
        }
        for (int i = 0; i<parser.count; i++) {
            //[self.msgArray addObject:[[NSMutableArray alloc]init]];
            [self.msgArray addObject:[parser objectAtIndex:i]];
        }

    }
    else{
        //UIAlertView *alert;
        //alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[[parser objectAtIndex:0]objectAtIndex:1] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        //[alert show];
        Max_Count = loadCount;
    }
    //NSLog([[parser objectAtIndex:0]objectAtIndex:0]);
    if (self.isRecevied) {
        [self performSelector:@selector(endRefresh) withObject:nil];
    }
    else
    {
        [self performSelector:@selector(endLoadMore) withObject:nil];
    }
}

//是显示更多
- (BOOL)hasRefreshFooterView {
    if (self.msgArray.count > 0 && loadCount < Max_Count) {
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
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    self.navigationItem.title = @"消息";
    //self.arr= [NSMutableArray array];
    
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
    
    self.msgArray = [[NSMutableArray alloc]init];
}

- (void)endRefresh {
    loadCount =1;
    
    //self.arr = self.msgArray;
    [self.tableView reloadData];
    
    [self.refreshControll endPullDownRefreshing];
}
- (void)endLoadMore {
    loadCount ++;
    //NSMutableArray *_stuArray = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"第%d次就加载更多,共%d次",loadCount,Max_Count ],@"更多1",@"更多2",@"更多3", nil];
    //[self.arr addObjectsFromArray:_stuArray];
    [self.tableView reloadData];
    
    [self.refreshControll endPullUpLoading];
    
}


#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgArray.count;
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
    //UITableViewCell *cell =[UITableViewCell alloc];
    UITableViewCell *cell = [self customCellByXib0:tableView withIndexPath:indexPath];
    return cell;
}

//通过代码自定义cell
-(UITableViewCell *)customCellByXib0:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"MessageXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //头像
        CGRect imageRect = CGRectMake(5, 5, 55, 55);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        imageView.tag = 4;
        
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
        CGRect nameRect = CGRectMake(i.x+j.width+10, i.y+7, self.view.bounds.size.width/2, 10);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        nameLabel.tag = 1;
        nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        
        //内容
        i =imageRect.origin;
        j = imageRect.size;
        CGRect messageRect = CGRectMake(i.x+j.width+10, i.y+23, self.view.bounds.size.width-j.width-25, 29);
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:messageRect];
        messageLabel.font = [UIFont boldSystemFontOfSize:12];
        messageLabel.tag = 2;
        messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        messageLabel.numberOfLines =2;
        messageLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:messageLabel];
        
        //时间
        CGRect timeRect = CGRectMake(self.view.bounds.size.width-j.width-25, i.y+7, 75, 10);
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:timeRect];
        timeLabel.font = [UIFont boldSystemFontOfSize:11];
        timeLabel.tag = 3;
        timeLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:timeLabel];
        
        //msgID
        UILabel *msgIDLabel = [[UILabel alloc]initWithFrame:timeRect];
        msgIDLabel.tag = 5;
        msgIDLabel.hidden = YES;
        [cell.contentView addSubview:msgIDLabel];

        //cut
        UILabel *cut = [[UILabel alloc]initWithFrame:CGRectMake(0,64,self.view.bounds.size.width,1)];
        cut.backgroundColor = [UIColor grayColor];
        cut.text = @"";
        [cell.contentView addSubview:cut];
    }

    NSUInteger row = [indexPath row];
    NSMutableArray *dic  = [self.msgArray objectAtIndex:row];
    //NSString *a = [dic objectAtIndex:0];
    //msgID
    ((UILabel *)[cell.contentView viewWithTag:5]).text = [dic objectAtIndex:0];
    //发送人
    NSString *sender = [dic objectAtIndex:3];
    if([sender isEqualToString:@"0"])
    {
        sender = @"系统消息";
    }
    ((UILabel *)[cell.contentView viewWithTag:1]).text = sender;
    //内容
    int i = 4;// message atindex in array
    NSMutableString *message = [[NSMutableString alloc]init];
     [message appendString:[dic objectAtIndex:i]];
    if (dic.count==i+2) {
        [message appendString:[dic objectAtIndex:i+1]];
    }
    ((UILabel *)[cell.contentView viewWithTag:2]).text = message;
    //时间
    ((UILabel *)[cell.contentView viewWithTag:3]).text = [dic objectAtIndex:2];
    //头像
    ((UIImageView *)[cell.contentView viewWithTag:4]).image = [UIImage imageNamed:@"Email.png"];
    
    //办公室
    //((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *msgid = ((UILabel *)[cell viewWithTag:5]).text;
    
    MessageDetailViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"msgwebview"];
    asd.msgid  = msgid;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [asd.navigationItem setBackBarButtonItem:backButton];
    //[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"webview"]animated:YES];
    [self.navigationController pushViewController:asd animated:YES];
    
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
    //self.arr = nil;
    self.tableView = nil;
    self.refreshControll = nil;
}
@end
