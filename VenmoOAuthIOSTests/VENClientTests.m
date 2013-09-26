#import <XCTest/XCTest.h>
#import "VENTestBase.h"
#import "VENClient.h"
#import "VENLoginViewController.h"
#define TEST_TOKEN @"12345"


@interface VENClientTests : XCTestCase

@property (strong, nonatomic) VENClient *client;

@end

@implementation VENClientTests

- (void)setUp
{
    [super setUp];
    self.client = [[VENClient alloc] initWithAccessToken:TEST_TOKEN];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInit
{
    EXP_expect(self.client.baseURL).to.equal([NSURL URLWithString:API_BASE_URL]);
    EXP_expect(self.client.accessToken).to.equal(TEST_TOKEN);
    EXP_expect(self.client.operationQueue).toNot.beNil;
    EXP_expect(self.client.operationQueue.maxConcurrentOperationCount).to.equal(NSOperationQueueDefaultMaxConcurrentOperationCount);
}


@end
