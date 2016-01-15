//
//  MyCustomURLProtocol.m
//  TVML Viewer
//
//  Created by Doug DeJulio on 1/14/16.
//  Copyright © 2016 AISB. All rights reserved.
//

#import "MyCustomURLProtocol.h"

@implementation MyCustomURLProtocol

+ (BOOL) canInitWithRequest:(NSURLRequest *)request
{
    NSLog(@"Handler checking request: %@", request);
    if ([request.URL.scheme isEqualToString:@"alert"]) {
        NSLog(@"Handling URL: %@", request.URL);
        return YES;
    } else {
        return NO;
    }
}

+ (NSURLRequest *) canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

+ (BOOL) requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
{
    return NO;
}

- (void) startLoading
{
    NSURL *url = self.request.URL;
    NSLog(@"Loading URL: %@", url);
    NSData *data;
    NSString *alertTemplate = @"<document><alertTemplate><title>Alert</title><description>%@</description><button navtype=\"back\"><text>OK</text></button></alertTemplate></document>";
    NSString *compiledTvml = [NSString stringWithFormat:alertTemplate, self.request.URL.path];
    data = [compiledTvml dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:@"text/tvml" expectedContentLength:data.length textEncodingName:@"UTF-8"];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowedInMemoryOnly];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void) stopLoading
{

}

@end
