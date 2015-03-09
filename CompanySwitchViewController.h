//
//  phcxViewController.h
//  iLygport
//
//  Created by leo on 15/2/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"

@interface CompanySwitchViewController : UIViewController<DropDownChooseDelegate,DropDownChooseDataSource,UIWebViewDelegate>
@property(retain,nonatomic)NSString *userID;
@property(retain,nonatomic)NSString *url;

@end
