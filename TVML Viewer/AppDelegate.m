//
//  AppDelegate.m
//  TVML Viewer
//
//  Created by Doug DeJulio on 11/7/15.
//  Copyright © 2015 AISB. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Deal with preferences.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:@{@"enable_custom_start": @NO}];

    TVApplicationControllerContext *appControllerContext = [[TVApplicationControllerContext alloc] init];

    // Set up the options relating to JavaScript.
    NSURL *jsURL = [[NSBundle mainBundle] URLForResource:@"app" withExtension:@"js" subdirectory:@"js"];
    NSURL *jsDirURL = [jsURL URLByDeletingLastPathComponent];
    appControllerContext.javaScriptApplicationURL = jsURL;

    NSURL *indexURL;
    if (![defaults boolForKey:@"enable_custom_start"]) {
        // Only load our static TVML assets if "custom start URL" is turned off.
        NSSet *tags = [NSSet setWithObject:@"static-tvml"];
        NSBundleResourceRequest *resourceRequest = [[NSBundleResourceRequest alloc] initWithTags:tags];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [resourceRequest beginAccessingResourcesWithCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                [NSException raise:@"error" format:@"error: %@", error]; // This is a little scary.
            } else {
            
            }
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        // If we got here, I *think* the "URLForResource" stuff will work.
    
        // Set up the options relating to TVML and assets.
        indexURL = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"tvml" subdirectory:@"tvml"];
    } else {
        // If "custom start URL" is turned on, use that.
        indexURL = [NSURL URLWithString:[defaults stringForKey:@"custom_url"]];
        if (!indexURL) {
            [NSException raise:@"Missing Custom URL" format:@"%@", @"Custom URL turned on but no custom URL set."];
        }
    }
    NSURL *rootURL = [indexURL URLByDeletingLastPathComponent];

    NSMutableDictionary *myLaunchOptions = [launchOptions mutableCopy];
    if (!myLaunchOptions) {
        myLaunchOptions = [[NSMutableDictionary alloc] init];
    }
    myLaunchOptions[@"JSURL"] = [jsURL absoluteString];
    myLaunchOptions[@"JSDIRURL"] = [jsDirURL absoluteString];
    myLaunchOptions[@"STARTURL"] = [indexURL absoluteString];
    myLaunchOptions[@"BASEURL"] = [rootURL absoluteString];
    appControllerContext.launchOptions = myLaunchOptions;

    [TVElementFactory registerViewElementClass:[TVViewElement class] forElementName:@"html"];
    [[TVInterfaceFactory sharedInterfaceFactory] setExtendedInterfaceCreator:self];

    self.appController = [[TVApplicationController alloc] initWithContext:appControllerContext window: self.window delegate: self];

    return YES;
}

- (NSURL *) URLForResource:(NSString *)resourceName
{
    // If we want to add new "resource://" URLs, we put 'em here.
    return nil;
}

- (UIView *) viewForElement:(TVViewElement *)element existingView:(UIView *)existingView
{
    if ([element.elementName isEqualToString:@"html"]) {
        UITextView *view;
        if (existingView) {
            view = (UITextView *)existingView;
        } else {
            view = [[UITextView alloc] init];
        }
        // This only works with absolute URLs.  Alas.

        NSURL *url = [NSURL URLWithString:element.attributes[@"src"]];
        if (!url) {
            view.text = @"No src attribute set.";
            view.textColor = [UIColor purpleColor];
            view.backgroundColor = [UIColor yellowColor];
            return view;
        }
        NSError *error;
        NSDictionary *attributes;
        NSData *htmlData = [NSData dataWithContentsOfURL:url];
        view.attributedText = [[NSAttributedString alloc] initWithData:htmlData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:&attributes error:&error];
        return view;
    }

    // If none of that applies, punt.
    return nil;
}

- (UIViewController *) viewControllerForElement:(TVViewElement *)element existingViewController:(UIViewController *)existingViewController
{
    return nil;
}

- (void)appController:(TVApplicationController *)appController evaluateAppJavaScriptInContext:(nonnull JSContext *)context
{
    // Make our utility funciton object available within JavaScript.
    context[@"tvjsutil"] = [TVJSUtil new];
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
}

@end
