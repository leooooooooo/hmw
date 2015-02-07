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

//学生
#define nameTag          1
#define classTag         2
#define stuNumberTag     3
#define imageTag         4
#define nameFontSize    15
#define fontSize        12

//老师
#define teaNameTag       1
#define teaTypeTag       2
#define teaOfficeTag     3

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
