//
//  changePasswordViewController.m
//  iLygport
//
//  Created by leo on 15/2/7.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "changePasswordViewController.h"

@interface changePasswordViewController ()

@end

@implementation changePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.passwordNew.secureTextEntry= YES;
    self.passwordOld.secureTextEntry= YES;
    self.passwordConfirmed.secureTextEntry= YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clearPassword:(id)sender {
    self.passwordNew.text = nil;
    self.passwordOld.text = nil;
    self.passwordConfirmed.text=nil;

    
}

- (IBAction)postChange:(id)sender {
    if ([self.passwordNew isEqual:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认修改" message:@"密码不能为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        if([self.passwordNew isEqual:self.passwordConfirmed])
        {
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认修改" message:@"请保持两次密码输入一致" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
    }
    }
}
@end
