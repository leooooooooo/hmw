//
//  changeInfoViewController.h
//  iLygport
//
//  Created by leo on 15/2/10.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "Header.h"

@interface changeInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *phone;
- (IBAction)clearemail:(id)sender;
- (IBAction)cleartel:(id)sender;
- (IBAction)clearphone:(id)sender;
- (IBAction)sendInfo:(id)sender;


@end
