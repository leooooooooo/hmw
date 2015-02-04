//
//  MyBusinessViewController.h
//  iLygport
//
//  Created by leo on 15/1/22.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

@interface MyBusinessViewController : UIViewController
{
    KeychainItemWrapper *status;
    KeychainItemWrapper *info;
    NSString *userid;
}
@property (retain, nonatomic) IBOutlet UIButton *returnlogin;

@end
