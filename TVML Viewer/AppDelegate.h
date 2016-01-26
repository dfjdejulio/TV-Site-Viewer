//
//  AppDelegate.h
//  TV Site Viewer
//
//  Created by Doug DeJulio on 11/7/15.
//  Copyright © 2015 AISB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TVMLKit/TVMLKit.h>
#import "TVJSUtil.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, TVApplicationControllerDelegate, TVInterfaceCreating>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TVApplicationController *appController;

@end

