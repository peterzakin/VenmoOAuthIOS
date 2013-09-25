#import "VENClient.h"
#import "VENLoginViewController.h"

@interface VENClient ()

///// move these
@property (readwrite, nonatomic, strong) NSURL *baseURL;
@property (readwrite, nonatomic, strong) NSOperationQueue *operationQueue;
/////


@property (readwrite, nonatomic, strong) NSString *clientID;
@property (readwrite, nonatomic, strong) NSString *clientSecret;
@property (readwrite, nonatomic, assign) VENAccessScope scopes;
@property (readwrite, nonatomic, assign) VENResponseType responseType;
@property (readwrite, nonatomic, strong) NSURL *redirectURL;


@end

@implementation VENClient

- (id)initWithClientID:(NSString *)clientID
          clientSecret:(NSString *)clientSecret
                scopes:(VENAccessScope)scopes
          responseType:(VENResponseType)responseType
           redirectURL:(NSURL *)redirectURL
              delegate:(id<VENClientDelegate>)delegate
{
    NSParameterAssert(clientID != nil && clientSecret != nil && redirectURL != nil);
    self = [super init];
    if (self) {
        self.clientID = clientID;
        self.clientSecret = clientSecret;
        self.scopes = scopes;
        self.responseType = responseType;
        self.redirectURL = redirectURL;
        self.delegate = delegate;
    }
    return self;
}

- (BOOL)authorize
{
    VENLoginViewController *loginVC = [[VENLoginViewController alloc] initWithClientId:self.clientID clientSecret:self.clientSecret scopes:self.scopes reponseType:self.responseType redirectURL:self.redirectURL delegate:self];
    loginVC.delegate = self;
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:loginVC animated:YES completion:nil];
    return YES;
}

#pragma mark - VENLoginViewControllerDelegate

- (void)loginViewController:(VENLoginViewController *)loginViewController finishedWithAccessToken:(NSString *)accessToken error:(NSError *)error
{
    [loginViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
