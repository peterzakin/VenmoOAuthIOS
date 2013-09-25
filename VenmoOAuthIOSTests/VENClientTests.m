#import <XCTest/XCTest.h>
#import "VENTestBase.h"
#import "VENClient_Internal.h"
#import "VENLoginViewController.h"

@interface VENClientTests : XCTestCase

@property (strong, nonatomic) VENClient *client;

@end

@implementation VENClientTests

- (void)setUp
{
    [super setUp];
    self.client = [[VENClient alloc] initWithClientID:CLIENT_ID clientSecret:CLIENT_SECRET scopes:SCOPES responseType:VENResponseTypeCode redirectURL:REDIRECT_URL delegate:nil];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInit
{
    VENClient *client = [[VENClient alloc] initWithClientID:CLIENT_ID clientSecret:CLIENT_SECRET scopes:SCOPES responseType:VENResponseTypeCode redirectURL:REDIRECT_URL delegate:nil];
    EXP_expect(client.clientID).to.equal(CLIENT_ID);
    EXP_expect(client.clientSecret).to.equal(CLIENT_SECRET);
    EXP_expect(client.scopes).to.equal(SCOPES);
    EXP_expect(client.responseType).to.equal(VENResponseTypeCode);
    EXP_expect(client.redirectURL).to.equal(REDIRECT_URL);
    EXP_expect(client.delegate).to.beNil;
}

- (void)testOAuthViewControllerInitialization
{
    VENLoginViewController *loginVC = [VENClient OAuthViewControllerWithClientID:CLIENT_ID clientSecret:CLIENT_SECRET scopes:SCOPES responseType:VENResponseTypeCode redirectURL:REDIRECT_URL delegate:nil];
    EXP_expect(loginVC.clientId).to.equal(CLIENT_ID);
    EXP_expect(loginVC.clientSecret).to.equal(CLIENT_SECRET);
    EXP_expect(loginVC.scopes).to.equal(SCOPES);
    EXP_expect(loginVC.responseType).to.equal(VENResponseTypeCode);
    EXP_expect(loginVC.redirectURL).to.equal(REDIRECT_URL);
    EXP_expect(loginVC.delegate).to.beNil;
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
