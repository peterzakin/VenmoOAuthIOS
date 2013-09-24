//
//  VenmoOAuthIOS.h
//  VenmoOAuthIOS
//
//  Created by Peter Zakin on 9/23/13.
//  Copyright (c) 2013 Venmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol VENAuthViewControllerDelegate;

@class VENAuthViewController;

@interface VENClient : NSObject

+ (VENClient *)sharedClient;
+ (VENAuthViewController *)OAuthViewControllerWithClientID:(NSString *)clientID
                                              clientSecret:(NSString *)clientSecret
                                                    scopes:(NSSet *)scopes
                                              responseType:(NSString *)responseType
                                               redirectURL:(NSURL *)redirectURL
                                                  delegate:(id<VENAuthViewControllerDelegate>)delegate;
+ (NSURL *)authorizationURLWithClientID;

@end
