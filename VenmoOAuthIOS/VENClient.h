#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VENDefines.h"

@protocol VENClientDelegate, VENAuthViewControllerDelegate;
@class VENAuthViewController;

@interface VENClient : NSObject

@property (readonly, nonatomic, strong) NSString *clientID;
@property (readonly, nonatomic, strong) NSString *clientSecret;
@property (readonly, nonatomic, assign) VENAccessScope scopes;
@property (readonly, nonatomic, assign) VENResponseType responseType;
@property (readonly, nonatomic, strong) NSURL *redirectURL;
@property (nonatomic, weak) id<VENClientDelegate> delegate;

- (id)initWithClientID:(NSString *)clientID
          clientSecret:(NSString *)clientSecret
                scopes:(VENAccessScope)scopes
          responseType:(VENResponseType)responseType
           redirectURL:(NSURL *)redirectURL
              delegate:(id<VENClientDelegate>)delegate;


//// remove this
+ (VENClient *)sharedClient;
///////
////// refactor this
+ (VENAuthViewController *)OAuthViewControllerWithClientID:(NSString *)clientID
                                              clientSecret:(NSString *)clientSecret
                                                    scopes:(VENAccessScope)scopes
                                              responseType:(VENResponseType)responseType
                                               redirectURL:(NSURL *)redirectURL
                                                  delegate:(id<VENAuthViewControllerDelegate>)delegate;
/////////


@end

@protocol VENClientDelegate <NSObject>
@optional

- (void)clientDidAuthorize:(VENClient *)client;
- (void)clientDidNotAuthorize:(VENClient *)client;

@end
