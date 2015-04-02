//
//  AppDelegate.m
//  航贸网
//
//  Created by leo on 14/11/9.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "AppDelegate.h"
#import "DeviceSender.h"
#define alert_tag_push 10

@interface AppDelegate ()
-(void)alertNotice:(NSString *)title withMSG:(NSString *)msg cancleButtonTitle:(NSString *)cancleTitle otherButtonTitle:(NSString *)otherTitle;
@end

@implementation AppDelegate
@synthesize deviceToken;
@synthesize isbinding;
@synthesize userid;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                         settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                         categories:nil]];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    //判断程序是不是由推送服务完成的
    if (launchOptions) {
        NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey) {
            [self alertNotice:@"" withMSG:@"这是通过推送窗口启动的程序，你可以在这里处理推送内容" cancleButtonTitle:@"知道了" otherButtonTitle:nil];
        }
    }

    return YES;
}

#pragma mark - 实现远程推送需要实现的监听接口
/** 接收从苹果服务器返回的唯一的设备token，该token需要发送回推送服务器*/
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString* token = [NSString stringWithFormat:@"%@",deviceToken];
    NSLog(@"apns -> 生成的devToken:%@", token);
    //    [self alertNotice:@"" withMSG:[NSString stringWithFormat:@"从苹果推送服务器返回的设备标识:%@",deviceToken] cancleButtonTitle:@"Ok" otherButtonTitle:@""];
    
    //self.deviceToken=[[NSString alloc]initWithData:deviceToken encoding:NSUTF8StringEncoding];// deviceToken;
    DeviceSender * sender = [[DeviceSender alloc]initWithDelegate:self ];
    [sender sendDeviceToPushServer:token];
}


/** 接收注册推送通知功能时出现的错误，并做相关处理*/
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"apns -> 注册推送功能时发生错误， 错误信息:\n %@", err);
    //    [self alertNotice:@"注册推送功能时发生错误" withMSG:[err localizedDescription] cancleButtonTitle:@"Ok" otherButtonTitle:@""];
}

//程序处于启动状态，或者在后台运行时，会接收到推送消息，解析处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"\napns -> didReceiveRemoteNotification,Receive Data:\n%@", userInfo);
    //把icon上的标记数字设置为0,
    application.applicationIconBadgeNumber = 0;
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"羊屁股"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"点这个没用"
                                              otherButtonTitles:@"这个也没用",nil];
        alert.tag = alert_tag_push;
       // [alert show];
    }
}

#pragma mark - 处理推送服务器push过来的数据
-(void) pushAlertButtonClicked:(NSInteger)buttonIndex
{
    NSLog(@"响应推送对话框");
    if (buttonIndex == 0) {
        NSLog(@"--->点了第一个按钮");
    } else {
        NSLog(@"--->点了第二个按钮");
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case alert_tag_push:
        {
            [self pushAlertButtonClicked:buttonIndex];
        }
            break;
        default:
            break;
    }
}

-(void)alertNotice:(NSString *)title withMSG:(NSString *)msg cancleButtonTitle:(NSString *)cancleTitle otherButtonTitle:(NSString *)otherTitle
{
    UIAlertView *alert;
    if(!otherTitle || [otherTitle isEqualToString:@""])
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:nil,nil];
    else
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:otherTitle,nil];
    [alert show];
    //[alert release];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "leo.___" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"___" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"___.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
