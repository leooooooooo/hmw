//
//  changePasswordViewController.h
//  iLygport
//
//  Created by leo on 15/2/7.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passwordOld;
@property (weak, nonatomic) IBOutlet UITextField *passwordNew;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmed;
- (IBAction)clearPassword:(id)sender;
- (IBAction)postChange:(id)sender;


@end
