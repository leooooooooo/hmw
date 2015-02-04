//
//  widget.m
//  iLygport
//
//  Created by leo on 15/1/7.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "widget.h"
#import "FileOwner.h"
#import "UIView+Ext.h"
#import "NavBar.h"
#import "AdScrollView.h"
#import "AdDataModel.h"


@implementation widget : NSObject

#pragma mark - 定义父视图
- (void)setSuperViewController:(UIViewController *)ViewController{
    superViewController = ViewController;
}
#pragma mark - 构建导航
- (void)createNavBar:(UIView *)view LoadRact:(CGRect)frame
{
    NavBar *nav = [NavBar loadFromNib];
    [nav setSuperViewController:superViewController];
    [nav setFrame:frame];
    [view addSubview:nav];
}
#pragma mark - 构建广告滚动视图
- (void)createScrollView:(UIView *)view LoadRact:(CGRect)frame
{
    AdScrollView * scrollView = [[AdScrollView alloc]initWithFrame:frame];
    AdDataModel * dataModel = [AdDataModel adDataModelWithImageNameAndAdTitleArray];
    //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //NSLog(@"%@",dataModel.adTitleArray);
    scrollView.imageNameArray = dataModel.imageNameArray;
    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [scrollView setAdTitleArray:dataModel.adTitleArray withShowStyle:AdTitleShowStyleLeft];
    
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    //[scrollView setFrame:frame];
    [view addSubview:scrollView];
}


@end

