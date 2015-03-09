//
//  CompanyOnlyViewController.h
//  iLygport
//
//  Created by leo on 15/3/9.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"

@interface CompanyOnlyViewController : UIViewController<DropDownChooseDelegate,DropDownChooseDataSource,UIWebViewDelegate>
@property(retain,nonatomic)NSString *userID;
@property(retain,nonatomic)NSString *url;

@end
