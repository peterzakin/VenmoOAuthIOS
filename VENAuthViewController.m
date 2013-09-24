#define BASE_URL @"https://venmo.com/"

#import "VENAuthViewController.h"
#import <UIKit/UIKit.h>

@interface VENAuthViewController ()

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) NSString* clientId;
@property (strong, nonatomic) NSString* clientSecret;
@property (strong, nonatomic) NSSet *scopes;
@property (strong, nonatomic) NSString *responseType;
@property (strong, nonatomic) NSURL *redirectURL;


@end

@implementation VENAuthViewController

- (id)initWithClientId:(NSString *)clientId
          clientSecret:(NSString *)clientSecret
                scopes:(NSSet *)scopes
           reponseType:(NSString *)responseType
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
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@oauth/authorize?client_id=%@&scope=%@&response_type=%@", BASE_URL, self.clientId, scopes, self.responseType]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
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
        
        return NO;
    }
    return YES;
}

@end
