//
//  EmptyViewController.h
//  iLygport
//
//  Created by leo on 15/3/10.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyViewController : UIViewController<UIWebViewDelegate>
@property(retain,nonatomic)NSString *userID;
@property(retain,nonatomic)NSString *url;

@end
