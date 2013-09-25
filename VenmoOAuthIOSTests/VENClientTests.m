#import <XCTest/XCTest.h>
#import "VENTestBase.h"
#import "VENClient.h"
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


@end
