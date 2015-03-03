//
//  CZTableViewController.h
//  iLygport
//
//  Created by leo on 15/2/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (retain,nonatomic) NSArray *teaArray;//老师资料

@end
