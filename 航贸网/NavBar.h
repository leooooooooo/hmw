//
//  UINavBar.h
//  LoadNibViewDemo
//
//  Created by Haven on 7/2/14.
//  Copyright (c) 2014 LF. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NavBar : UIView{
    UIViewController *superViewController;
}
- (void)setSuperViewController:(UIViewController *)ViewController;
- (IBAction)push:(id)sender;

@end
