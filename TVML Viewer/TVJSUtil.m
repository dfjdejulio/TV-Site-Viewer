//
//  TVJSUtil.m
//  TV Site Viewer
//
//  Created by Doug DeJulio on 1/14/16.
//  Copyright © 2016 AISB. All rights reserved.
//

#import "TVJSUtil.h"

@implementation TVJSUtil

- (void) nslog:(NSString *)message {
    NSLog(@"%@", message);
}

- (void) nslog:(NSString *) message withObject: (id) object {
    // NSLog will just get the object's "description", which is fine.
    NSLog(@"%@ : %@", message, object);
}

+ (NSString *) url:(NSString *)rel relativeTo:(NSString *)base
{
    NSString *absoluteString = [[NSURL URLWithString:rel relativeToURL:[NSURL URLWithString:base]] absoluteString];
    return absoluteString;
}

- (NSString *) url:(NSString *)rel relativeTo:(NSString *)base
{
    return [[self class] url:rel relativeTo:base];
}

- (NSString *) load:(NSString *)urlString
{
    NSError *loadError = nil;
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *value = [NSString stringWithContentsOfURL:url usedEncoding:NULL error:&loadError];
    if (!value) {
        NSLog(@"Couldn't load from URL %@, error %@", url, loadError);
    } else {
        NSLog(@"Loaded from URL %@", url);
    }
    return value;
}

- (BOOL) open:(NSString *) urlString
{
    __block BOOL status = NO;
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[UIApplication sharedApplication] openURL:url options: @{} completionHandler: ^(BOOL success) { status = success; dispatch_semaphore_signal(semaphore); }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return status;
}


@end
