//
//  TVJSUtil.m
//  TVML Viewer
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

@end
