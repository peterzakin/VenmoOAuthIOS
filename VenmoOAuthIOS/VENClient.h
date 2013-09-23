//
//  VenmoOAuthIOS.h
//  VenmoOAuthIOS
//
//  Created by Peter Zakin on 9/23/13.
//  Copyright (c) 2013 Venmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VENClient : NSObject

+ (UIViewController *)OAuthViewControllerWithClientID:(NSString *)clientID
                                         clientSecret:(NSString *)clientSecret
                                               scopes:(NSSet *)scopes;

@end
