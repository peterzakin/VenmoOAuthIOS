#import "VENAuthViewController.h"
#import <UIKit/UIKit.h>

@interface VENAuthViewController ()

@end

@implementation VENAuthViewController

+ (NSString *)stringForResponseType:(VENResponseType)responseType
{
    return (responseType == VENResponseTypeCode) ? @"code" : @"token";
}


- (id)initWithClientId:(NSString *)clientId
          clientSecret:(NSString *)clientSecret
                scopes:(NSSet *)scopes
           reponseType:(VENResponseType)responseType
           redirectURL:(NSURL *)redirectURL
              delegate:(id<VENAuthViewControllerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.clientId = clientId;
        self.clientSecret = clientSecret;
        self.scopes = scopes;
        self.responseType = responseType;
        self.redirectURL = redirectURL;
        self.delegate = delegate;
    }
    return self;
}

- (NSURL *)authorizationURL
{
    NSString *scopes = [self.scopes.allObjects componentsJoinedByString:@","];
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@oauth/authorize?client_id=%@&scope=%@&response_type=%@",
                                 API_BASE_URL, self.clientId, scopes, [VENAuthViewController stringForResponseType:self.responseType]]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect webViewFrame = CGRectMake(0,
                                     statusBarHeight,
                                     self.view.bounds.size.width,
                                     self.view.bounds.size.height - statusBarHeight);
    self.webView = [[UIWebView alloc] initWithFrame:webViewFrame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    NSURL *authorizationURL = [self authorizationURL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:authorizationURL]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *host = request.URL.host;
    if ([host isEqualToString:self.redirectURL.host]) {
        NSString *queryString = request.URL.query;
        NSString *accessToken = nil;
        NSError *error = nil;
        // Client-side flow: just grab the access token
        if (self.responseType == VENResponseTypeToken) {
            accessToken = [queryString stringByReplacingOccurrencesOfString:@"access_token=" withString:@""];
        // Server-side flow:
        } else if (self.responseType == VENResponseTypeCode) {
            NSString *code = [queryString stringByReplacingOccurrencesOfString:@"code=" withString:@""];
            NSString *url = [NSString stringWithFormat:@"%@oauth/access_token?client_id=%@&client_secret=%@&code=%@",
                                   API_BASE_URL, self.clientId, self.clientSecret, code];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval :10.0];
            [request setHTTPMethod:@"POST"];
            NSURLResponse *response = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            if (!error) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                if (!error) accessToken = [json objectForKey:@"access_token"];
            }
        }
        [self.delegate authViewController:self finishedWithAccessToken:accessToken error:error];
        return NO;
    }
    return YES;
}

@end
