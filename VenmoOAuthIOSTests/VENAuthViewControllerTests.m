#import <XCTest/XCTest.h>
#import "VENDefines.h"
#import "VENTestBase.h"
#import "VENAuthViewController_Internal.h"
#define TEST_TOKEN @"1234"

@interface VENAuthViewControllerTests : XCTestCase

@property (nonatomic, strong) VENAuthViewController *tokenAuthVC;
@property (nonatomic, strong) VENAuthViewController *codeAuthVC;
@property (nonatomic, strong) UIViewController <VENAuthViewControllerDelegate> *mockAuthDelegate;

@end

@implementation VENAuthViewControllerTests

- (void)setUp
{
    [super setUp];


    self.mockAuthDelegate = mockObjectAndProtocol([UIViewController class], @protocol(VENAuthViewControllerDelegate));
    self.tokenAuthVC = [[VENAuthViewController alloc] initWithClientId:CLIENT_ID
                                                      clientSecret:CLIENT_SECRET
                                                            scopes:SCOPES
                                                       reponseType:VENResponseTypeToken
                                                       redirectURL:REDIRECT_URL
                                                          delegate:self.mockAuthDelegate];
    self.codeAuthVC = [[VENAuthViewController alloc] initWithClientId:CLIENT_ID
                                                          clientSecret:CLIENT_SECRET
                                                                scopes:SCOPES
                                                           reponseType:VENResponseTypeCode
                                                           redirectURL:REDIRECT_URL
                                                              delegate:self.mockAuthDelegate];

}

- (void)tearDown
{

    [super tearDown];
}

- (void)testStringForResponseType
{
    NSString *s1 = [VENAuthViewController stringForResponseType:VENResponseTypeToken];
    EXP_expect(s1).to.equal(@"token");
    NSString *s2 = [VENAuthViewController stringForResponseType:0];
    EXP_expect(s2).to.equal(@"token");
    NSString *s3 = [VENAuthViewController stringForResponseType:VENResponseTypeCode];
    EXP_expect(s3).to.equal(@"code");
}

- (void)testStringForScopes
{
    NSString *s1 = [VENAuthViewController stringForScopes:VENAccessScopeNone];
    EXP_expect(s1).to.equal(@"");
    NSString *s2 = [VENAuthViewController stringForScopes:VENAccessScopeFeed];
    EXP_expect(s2).to.equal(@"access_feed");
    NSString *s3 = [VENAuthViewController stringForScopes:(VENAccessScopeFeed | VENAccessScopeProfile)];
    EXP_expect(s3).to.equal(@"access_feed,access_profile");
    NSString *s4 = [VENAuthViewController stringForScopes:(VENAccessScopeFeed | VENAccessScopeProfile | VENAccessScopePayments)];
    EXP_expect(s4).to.equal(@"access_feed,access_profile,make_payments");
    NSString *s5 = [VENAuthViewController stringForScopes:(VENAccessScopeFeed | VENAccessScopeProfile | VENAccessScopeFriends | VENAccessScopePayments)];
    EXP_expect(s5).to.equal(@"access_feed,access_friends,access_profile,make_payments");
}


- (void)testInit
{
    EXP_expect(self.tokenAuthVC.clientId).to.equal(CLIENT_ID);
    EXP_expect(self.tokenAuthVC.clientSecret).to.equal(CLIENT_SECRET);
    EXP_expect(self.tokenAuthVC.scopes).to.equal(SCOPES);
    EXP_expect(self.tokenAuthVC.responseType).to.equal(VENResponseTypeToken);
    EXP_expect(self.codeAuthVC.responseType).to.equal(VENResponseTypeCode);
    EXP_expect(self.tokenAuthVC.redirectURL).to.equal(REDIRECT_URL);
    EXP_expect(self.tokenAuthVC.delegate).to.equal(self.mockAuthDelegate);
}

- (void)testAuthorizationURL
{
    NSString *scopesString = [VENAuthViewController stringForScopes:self.tokenAuthVC.scopes];
    NSString *authURLString = [NSString stringWithFormat:@"%@oauth/authorize?client_id=%@&scope=%@&response_type=%@",
                               API_BASE_URL, self.tokenAuthVC.clientId, scopesString, [VENAuthViewController stringForResponseType:self.tokenAuthVC.responseType]];
    EXP_expect([self.tokenAuthVC authorizationURL]).to.equal([NSURL URLWithString:authURLString]);
}

- (void)testWebViewShouldStartLoadForAuthorizationRequest
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[self.tokenAuthVC authorizationURL]];
    BOOL shouldLoad = [self.tokenAuthVC webView:self.tokenAuthVC.webView shouldStartLoadWithRequest:request navigationType:UIWebViewNavigationTypeOther];
    EXP_expect(shouldLoad).to.beTruthy;
}

- (void)testWebViewShouldNotStartLoadForRedirectRequest
{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.tokenAuthVC.redirectURL];
    BOOL shouldLoad = [self.tokenAuthVC webView:self.tokenAuthVC.webView shouldStartLoadWithRequest:request navigationType:UIWebViewNavigationTypeOther];
    EXP_expect(shouldLoad).to.beFalsy;
}

- (void)testDelegateShouldReceiveAccessToken
{
    // VENResponseTypeToken
    NSString *requestString = [NSString stringWithFormat:@"%@/?access_token=%@", self.tokenAuthVC.redirectURL, TEST_TOKEN];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    [self.tokenAuthVC webView:self.tokenAuthVC.webView shouldStartLoadWithRequest:request navigationType:UIWebViewNavigationTypeOther];
    [verify(self.mockAuthDelegate) authViewController:self.tokenAuthVC finishedWithAccessToken:TEST_TOKEN error:nil];

    // VENResponseTypeCode
    NSString *requestString2 = [NSString stringWithFormat:@"%@/?code=%@", self.codeAuthVC.redirectURL, TEST_TOKEN];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString2]];
    [self.codeAuthVC webView:self.codeAuthVC.webView shouldStartLoadWithRequest:request2 navigationType:UIWebViewNavigationTypeOther];
    [verify(self.mockAuthDelegate) authViewController:self.codeAuthVC finishedWithAccessToken:(NSString *)anything() error:nil];
}

@end
