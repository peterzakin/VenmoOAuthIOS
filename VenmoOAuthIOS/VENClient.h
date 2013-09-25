#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VENDefines.h"

@protocol VENAuthViewControllerDelegate;
@class VENAuthViewController;

@interface VENClient : NSObject

+ (VENClient *)sharedClient;
+ (VENAuthViewController *)OAuthViewControllerWithClientID:(NSString *)clientID
                                              clientSecret:(NSString *)clientSecret
                                                    scopes:(VENAccessScope)scopes
                                              responseType:(VENResponseType)responseType
                                               redirectURL:(NSURL *)redirectURL
                                                  delegate:(id<VENAuthViewControllerDelegate>)delegate;

@end
