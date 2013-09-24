#import "VENClient.h"

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
                                              responseType:(VENResponseType)responseType
                                               redirectURL:(NSURL *)redirectURL
                                                  delegate:(id<VENAuthViewControllerDelegate>)delegate
{
    VENAuthViewController *authViewController = [[VENAuthViewController alloc] initWithClientId:clientID clientSecret:clientSecret scopes:scopes reponseType:responseType redirectURL:redirectURL delegate:delegate];

    return authViewController;
}



@end
