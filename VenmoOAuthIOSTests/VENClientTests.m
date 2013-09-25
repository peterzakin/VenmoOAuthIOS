#import <XCTest/XCTest.h>
#import "VENTestBase.h"
#import "VENClient_Internal.h"

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

- (void)testSharedClient
{
    VENClient *client = [VENClient sharedClient];
    EXP_expect(client).toNot.beNil;
    VENClient *client2 = [VENClient sharedClient];
    EXP_expect(client).to.equal(client2);
}

- (void)testOAuthViewControllerInitialization
{
    
}

@end
