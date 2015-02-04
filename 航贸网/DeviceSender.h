//
//  DeviceSender.h
//  PushNotificationDemo
//
//  Created by 罗 永亮 on 12-2-20.
//  Copyright (c) 2012年 luoyl.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"


@protocol DeviceSenderDelegate;

/** */
@interface DeviceSender : NSObject
{
    NSMutableData               *receivedData;
    id<DeviceSenderDelegate>    delegate;

}

@property(nonatomic, assign) id<DeviceSenderDelegate> delegate;
@property(nonatomic,strong)    NSString *deviceToken;

- (id)initWithDelegate:(id<DeviceSenderDelegate>)delegate_;

-(void) sendDeviceToPushServer:(NSString*)deviceToken;

@end


@protocol DeviceSenderDelegate<NSObject>
@optional
//设备标识发送失败
-(void) didSendDeviceFailed:(DeviceSender*)sender withError:(NSError *)error;
//设备标识发送成功
-(void) didSendDeviceSuccess:(DeviceSender*)sender;
@end
