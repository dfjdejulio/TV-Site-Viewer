//
//  AppDelegate.h
//  TVML Viewer
//
//  Created by Doug DeJulio on 11/7/15.
//  Copyright © 2015 AISB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <TVMLKit/TVMLKit.h>
#import "TVJSUtil.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, TVApplicationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TVApplicationController *appController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationCachesDirectory;


@end

