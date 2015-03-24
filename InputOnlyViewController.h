//
//  InputOnlyViewController.h
//  iLygport
//
//  Created by leo on 15/3/12.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputOnlyViewController : UIViewController<UIWebViewDelegate>
@property(retain,nonatomic)NSString *userID;
@property(retain,nonatomic)NSString *url;
@property(retain,nonatomic)NSString *inputLabelName;

@end
