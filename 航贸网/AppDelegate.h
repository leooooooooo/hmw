//
//  AppDelegate.h
//  航贸网
//
//  Created by leo on 14/11/9.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DeviceSender.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,DeviceSenderDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(retain,nonatomic) NSString *deviceToken;
@property(retain,nonatomic) NSString *isbinding;
@property(retain,nonatomic) NSString *userid;

@property(retain,nonatomic) NSString *Update;
@property(retain,nonatomic) NSString *Version;
@property(retain,nonatomic) NSString *Url;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

