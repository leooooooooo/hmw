//
//  MessageDetailViewController.h
//  iLygport
//
//  Created by leo on 15/2/5.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailViewController : UIViewController<UIWebViewDelegate, UIScrollViewDelegate> {
}


@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(retain,nonatomic)NSString *URL;
@property(retain,nonatomic)NSString *msgid;
@end
