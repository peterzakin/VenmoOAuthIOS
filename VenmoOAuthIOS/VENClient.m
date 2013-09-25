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

////// remove
+ (VENClient *)sharedClient
{
    static VENClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
        _sharedClient.baseURL = [NSURL URLWithString:API_BASE_URL];
        _sharedClient.operationQueue = [[NSOperationQueue alloc] init];
        [_sharedClient.operationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    });
    return _sharedClient;
}

//////// refactor
+ (VENLoginViewController *)OAuthViewControllerWithClientID:(NSString *)clientID
                                              clientSecret:(NSString *)clientSecret
                                                    scopes:(VENAccessScope)scopes
                                              responseType:(VENResponseType)responseType
                                               redirectURL:(NSURL *)redirectURL
                                                  delegate:(id<VENLoginViewControllerDelegate>)delegate
{
    VENLoginViewController *loginVC = [[VENLoginViewController alloc] initWithClientId:clientID clientSecret:clientSecret scopes:scopes reponseType:responseType redirectURL:redirectURL delegate:delegate];

    return loginVC;
}



@end
