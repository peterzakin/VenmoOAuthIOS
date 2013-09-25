#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VENDefines.h"

@protocol VENAuthViewControllerDelegate;
@class VENAuthViewController;

@interface VENClient : NSObject

@property (readonly, nonatomic, strong) NSURL *baseURL;

// The operation queue which manages operations enqueued by the HTTP client.
@property (readonly, nonatomic, strong) NSOperationQueue *operationQueue;

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
