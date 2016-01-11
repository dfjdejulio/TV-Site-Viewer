//
//  JSCoreToyClass.h
//  TVML Viewer
//
//  Created by Doug DeJulio on 2016-01-11.
//  Copyright © 2016 AISB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSCoreToyClassExports <JSExport>

- (void) log: (NSString *) message;

@end

@interface JSCoreToyClass : NSObject <JSCoreToyClassExports>

@end
