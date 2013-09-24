#import <XCTest/XCTest.h>
#import "VENClient.h"
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

@interface VENClientTests : XCTestCase

@end

@implementation VENClientTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testOAuthViewControllerWithClientID
{
    NSSet *scopes = [NSSet setWithArray:@[@"make_payments"]];
    VENResponseType responseType = VENResponseTypeCode;
    NSURL *redirectURL = [NSURL URLWithString:REDIRECT_URL];

    UIViewController <VENAuthViewControllerDelegate> *controller =
    mockObjectAndProtocol([UIViewController class], @protocol(VENAuthViewControllerDelegate));

    VENAuthViewController *authVC = [VENClient OAuthViewControllerWithClientID:CLIENT_ID
                                                                  clientSecret:CLIENT_SECRET
                                                                        scopes:scopes
                                                                  responseType:responseType
                                                                   redirectURL:redirectURL
                                                                      delegate:controller];
    [authVC viewDidLoad];
    assertThat(CLIENT_ID, equalTo(authVC.clientId));
    assertThat(CLIENT_SECRET, equalTo(authVC.clientSecret));
    assert([scopes isEqualToSet:authVC.scopes]);
    assert(responseType == authVC.responseType);
    assertThat(redirectURL, equalTo(authVC.redirectURL));
    assertThat(authVC.webView, notNilValue());


}


@end
