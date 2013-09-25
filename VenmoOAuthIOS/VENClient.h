#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VENDefines.h"

@protocol VENAuthViewControllerDelegate;
@class VENAuthViewController;

@interface VENClient : NSObject

@property (readonly, nonatomic, strong) NSURL *baseURL;

+ (VENClient *)sharedClient;
+ (VENAuthViewController *)OAuthViewControllerWithClientID:(NSString *)clientID
                                              clientSecret:(NSString *)clientSecret
                                                    scopes:(VENAccessScope)scopes
                                              responseType:(VENResponseType)responseType
                                               redirectURL:(NSURL *)redirectURL
                                                  delegate:(id<VENAuthViewControllerDelegate>)delegate;
- (void)sendAsyncRequest:(NSURLRequest *)request
                 success:(void (^)(NSDictionary *json, NSURLResponse *response))success
                 failure:(void (^)(NSError *error, NSURLResponse *response))failure;

@end
