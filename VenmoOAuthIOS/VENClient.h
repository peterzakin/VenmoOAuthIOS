#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VENAuthViewController.h"
#import "VENDefines.h"

@protocol VENAuthViewControllerDelegate;
@class VENAuthViewController;

@interface VENClient : NSObject

+ (VENClient *)sharedClient;
+ (VENAuthViewController *)OAuthViewControllerWithClientID:(NSString *)clientID
                                              clientSecret:(NSString *)clientSecret
                                                    scopes:(NSSet *)scopes
                                              responseType:(VENResponseType)responseType
                                               redirectURL:(NSURL *)redirectURL
                                                  delegate:(id<VENAuthViewControllerDelegate>)delegate;

@end
