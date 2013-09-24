//
//  VENAuthViewController.h
//  VenmoOAuthIOS
//
//  Created by Peter Zakin on 9/23/13.
//  Copyright (c) 2013 Venmo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VENClient.h"
#import "VENDefines.h"

@protocol VENAuthViewControllerDelegate;

@interface VENAuthViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) id<VENAuthViewControllerDelegate> delegate;

+ (NSString *)stringForResponseType:(VENResponseType)responseType;

- (NSURL *)authorizationURL;

- (id)initWithClientId:(NSString *)clientId
          clientSecret:(NSString *)clientSecret
                scopes:(NSSet *)scopes
           reponseType:(VENResponseType)responseType
           redirectURL:(NSURL *)redirectURL
              delegate:(id<VENAuthViewControllerDelegate>)delegate;


@end

@protocol VENAuthViewControllerDelegate

- (void)authViewController:(VENAuthViewController *)authViewController
         finishedWithGrant:(NSString *)grant
                     error:(NSError *)error;

@end