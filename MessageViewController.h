//
//  MessageViewController.h
//  iLygport
//
//  Created by leo on 15/2/2.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLRefreshHeadController.h"
#import "soap.h"
#import "parser.h"
#import "Header.h"
#import "SWTableViewCell.h"

@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate,stringDelegate,parser,UITextFieldDelegate,SWTableViewCellDelegate>
{
    NSString *ServiceMobileApplication;
    NSString *soapmsg1,*soapmsg2;
    NSMutableString *soapmsg;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *arr;


@property (retain,nonatomic) NSMutableArray *msgArray;//学生资料
@end
