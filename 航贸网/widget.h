//
//  widget.h
//  iLygport
//
//  Created by leo on 15/1/7.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface widget : NSObject{
    UIViewController *superViewController;
}

- (void)setSuperViewController:(UIViewController *)ViewController;
- (void)createNavBar:(UIView *)view LoadRact:(CGRect)frame;
- (void)createScrollView:(UIView *)view LoadRact:(CGRect)frame;

@end