//
//  SettingsViewController.h
//  SettingsExample
//
//  Created by Jake Marsh on 10/8/11.
//  Copyright (c) 2011 Rubber Duck Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KeychainItemWrapper.h"



@interface SettingsViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>
{
    KeychainItemWrapper *status;
    KeychainItemWrapper *info;
    NSString *userid;
}

@property (retain,nonatomic) NSArray *stuArray;//学生资料
@property (retain,nonatomic) NSArray *teaArray;//老师资料
//@property (retain, nonatomic) IBOutlet UITableViewCell *teaCell;
@end
