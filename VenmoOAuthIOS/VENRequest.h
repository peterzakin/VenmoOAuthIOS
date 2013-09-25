//
//  VENRequest.h
//  VenmoOAuthIOS
//
//  Created by Ben Guo on 9/25/13.
//  Copyright (c) 2013 Venmo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VENRequest : NSObject

@property (readonly, nonatomic, strong) NSURL *baseURL;
// The operation queue which manages operations enqueued by the HTTP client.
@property (readonly, nonatomic, strong) NSOperationQueue *operationQueue;


- (void)sendAsyncRequest:(NSURLRequest *)request
       completionHandler:(void(^)(NSURLResponse *response, NSDictionary *json, NSError *connectionError))handler;


@end
