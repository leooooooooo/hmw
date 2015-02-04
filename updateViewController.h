//
//  updateViewController.h
//  iLygport
//
//  Created by leo on 15/1/29.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface updateViewController : UIViewController
{
    IBOutlet UIWebView *webView;
    UIActivityIndicatorView *activityIndicatorView;
}
@property(retain,nonatomic) NSString *url;

@end
