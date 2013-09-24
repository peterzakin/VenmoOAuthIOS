//
//  VenmoOAuthIOS.m
//  VenmoOAuthIOS
//
//  Created by Peter Zakin on 9/23/13.
//  Copyright (c) 2013 Venmo. All rights reserved.
//

#import "VENClient.h"
#import "VENAuthViewController.h"

@implementation VENClient

+ (VENClient *)sharedClient
{
    static VENClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    return _sharedClient;
}


+ (VENAuthViewController *)OAuthViewControllerWithClientID:(NSString *)clientID
                                         clientSecret:(NSString *)clientSecret
                                               scopes:(NSSet *)scopes
                                              responseType:(NSString *)responseType
                                               redirectURL:(NSURL *)redirectURL
                                             delegate:(id<VENAuthViewControllerDelegate>)delegate
{
    VENAuthViewController *authViewController = [[VENAuthViewController alloc] initWithClientId:clientID clientSecret:clientSecret scopes:scopes reponseType:responseType redirectURL:redirectURL delegate:delegate];

    return authViewController;
}



@end
