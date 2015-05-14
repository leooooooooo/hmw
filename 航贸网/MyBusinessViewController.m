//
//  MyBusinessViewController.m
//  iLygport
//
//  Created by leo on 15/1/22.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "MyBusinessViewController.h"
#import "header.h"

@interface MyBusinessViewController ()
@end

@implementation MyBusinessViewController

- (void)viewDidLoad {
    
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]autorelease];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];//隐藏
    status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    userid = [info objectForKey:(id)kSecAttrAccount];
    


}

-(void)viewDidAppear:(BOOL)animated
{
    [self showTabBar];
    [super viewDidAppear:YES];
    //NSString *autologin = [status objectForKey:(id)kSecValueData];
    if([userid isEqualToString:@""])
    {
        //[self performSegueWithIdentifier:@"relogin" sender:self];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}



- (IBAction)returnlogin:(id)sender {
    [status setObject:@"0" forKey:(id)kSecValueData];
    [info setObject:@"" forKey:(id)kSecAttrAccount];

    //[self performSegueWithIdentifier:@"relogin" sender:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc {
    [info setObject:@"" forKey:(id)kSecAttrAccount];
    [super dealloc];
}
@end
