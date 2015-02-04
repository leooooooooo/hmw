//
//  IndexViewController.h
//  iLygport
//
//  Created by leo on 15/1/5.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface CygnViewController : UIViewController<UIWebViewDelegate, UIScrollViewDelegate,EGORefreshTableHeaderDelegate> {
    //下拉视图
    EGORefreshTableHeaderView * _refreshHeaderView;
    //刷新标识，是否正在刷新过程中
    BOOL _reloading;
}

@property(retain,nonatomic)NSURLRequest *qqq;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(retain,nonatomic)NSString *URL;
@property(retain,nonatomic)NSString *userid;



@end