//
//  DeviceBindingTableViewController.h
//  iLygport
//
//  Created by leo on 15/1/28.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

@interface DeviceBindingTableViewController : UITableViewController
{
    KeychainItemWrapper *info;
    KeychainItemWrapper *isbinding;
}

@end
