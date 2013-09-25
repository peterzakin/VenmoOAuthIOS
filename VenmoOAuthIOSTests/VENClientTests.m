#import <XCTest/XCTest.h>
#import "VENTestBase.h"
#import "VENClient_Internal.h"
#import "VENAuthViewController_Internal.h"

@interface VENClientTests : XCTestCase

@property (strong, nonatomic) VENClient *client;

@end

@implementation VENClientTests

- (void)setUp
{
    [super setUp];
    self.client = [VENClient sharedClient];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSharedClient
{
    EXP_expect(self.client).toNot.beNil;
    EXP_expect(self.client.baseURL).to.equal([NSURL URLWithString:API_BASE_URL]);
    VENClient *client2 = [VENClient sharedClient];
    EXP_expect(self.client).to.equal(client2);
    EXP_expect(client2.baseURL).to.equal([NSURL URLWithString:API_BASE_URL]);
}

- (void)testOAuthViewControllerInitialization
{
    VENAuthViewController *authVC = [VENClient OAuthViewControllerWithClientID:CLIENT_ID clientSecret:CLIENT_SECRET scopes:SCOPES responseType:VENResponseTypeCode redirectURL:REDIRECT_URL delegate:nil];
    EXP_expect(authVC.clientId).to.equal(CLIENT_ID);
    EXP_expect(authVC.clientSecret).to.equal(CLIENT_SECRET);
    EXP_expect(authVC.scopes).to.equal(SCOPES);
    EXP_expect(authVC.responseType).to.equal(VENResponseTypeCode);
    EXP_expect(authVC.redirectURL).to.equal(REDIRECT_URL);
    EXP_expect(authVC.delegate).to.beNil;
}

- (void)testRequestWithMethod_basic
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET" path:@"test/path" parameters:@{@"key1" : @"value1"}];
    EXP_expect(request.URL.host).to.equal(self.client.baseURL.host);
    EXP_expect(request.HTTPMethod).to.equal(@"GET");
    EXP_expect(request.URL.path).to.equal(@"/test/path");
    EXP_expect(request.URL.query).to.equal(@"key1=value1");
}

- (void)testRequestWithMethod_threeParameters
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"POST" path:@"test/path" parameters:@{@"key1" : @"value1",
                                                                                                        @"key2" : @"value2",
                                                                                                        @"key3" : @"value3"}];
    EXP_expect(request.URL.query).to.equal(@"key1=value1&key2=value2&key3=value3");
}

- (void)testRequestWithMethod_percentEscapes
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"POST" path:@"test/path" parameters:@{@"key" : @":/?&=;+!@#$()~',*"}];
    EXP_expect(request.URL.query).to.equal(@"key=%3A%2F%3F%26%3D%3B%2B%21%40%23%24%28%29%7E%27%2C%2A");
}



@end
