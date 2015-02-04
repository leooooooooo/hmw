//
//  DeviceSender.m
//  PushNotificationDemo
//
//  Created by 罗 永亮 on 12-2-20.
//  Copyright (c) 2012年 luoyl.info. All rights reserved.
//


#import "DeviceSender.h"
#import "Header.h"
#import "AppDelegate.h"

@interface DeviceSender()
-(void) sendRequestByGet:(NSString*)urlString;
@end


@implementation DeviceSender
@synthesize delegate;

- (void)dealloc
{
    if (receivedData) {
        [receivedData release];
    }
    [super dealloc];
}


- (id)initWithDelegate:(id<DeviceSenderDelegate>)delegate_
{
    if (self = [super init]) {
        self.delegate = delegate_;
    }
    return self;
}


-(void) sendDeviceToPushServer:(NSString*)deviceToken
{
    AppDelegate *delegate=[(AppDelegate *)[UIApplication sharedApplication]delegate];
    delegate.deviceToken=[[deviceToken substringWithRange:NSMakeRange(1, deviceToken.length-2)]stringByReplacingOccurrencesOfString:@" " withString:@""];
}




@end
