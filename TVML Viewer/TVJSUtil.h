//
//  TVJSUtil.h
//  TVML Viewer
//
//  Created by Doug DeJulio on 1/14/16.
//  Copyright © 2016 AISB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TVJSUtilExports <JSExport>

// Log a string via NSLog.
- (void) nslog: (NSString *) message;

// NSLog with message and JavaScript object.
- (void) nslog: (NSString *) message withObject: (id) object;

@end

@interface TVJSUtil : NSObject <TVJSUtilExports>

@end
