#import <XCTest/XCTest.h>
#import "VENTestBase.h"
#import "VENAuthViewController_Internal.h"

@interface VENAuthViewControllerTests : XCTestCase

@property (nonatomic, strong) VENAuthViewController *authVC1;

@end

@implementation VENAuthViewControllerTests

- (void)setUp
{
    [super setUp];

    self.authVC1 = [[VENAuthViewController alloc] initWithClientId:CLIENT_ID
                                                                       clientSecret:CLIENT_SECRET
                                                                             scopes:SCOPES
                                                                        reponseType:VENResponseTypeToken
                                                                        redirectURL:REDIRECT_URL
                                                                           delegate:mockController];
    
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

- (void)testSetForScopes
{
    NSSet *s1 = [VENAuthViewController setForScopes:VENAccessScopeNone];
    EXP_expect(s1).to.equal([NSSet setWithArray:@[]]);
    NSSet *s2 = [VENAuthViewController setForScopes:VENAccessScopeFeed];
    EXP_expect(s2).to.equal([NSSet setWithArray:@[@"access_feed"]]);
    NSSet *s3 = [VENAuthViewController setForScopes:(VENAccessScopeFeed | VENAccessScopeProfile)];
    NSArray *a = @[@"access_feed", @"access_profile"];
    EXP_expect(s3).to.equal([NSSet setWithArray:a]);
}

- (void)testInit
{
    UIViewController <VENAuthViewControllerDelegate> *mockController =
    mockObjectAndProtocol([UIViewController class], @protocol(VENAuthViewControllerDelegate));

    EXP_expect(self.authVC1.clientId).to.equal(CLIENT_ID);
    EXP_expect(self.authVC1.clientSecret).to.equal(CLIENT_SECRET);
    EXP_expect(self.authVC1.scopes).to.equal(SCOPES);
    EXP_expect(self.authVC1.responseType).to.equal(VENResponseTypeToken);
    EXP_expect(self.authVC1.redirectURL).to.equal(REDIRECT_URL);
    EXP_expect(self.authVC1.delegate).to.equal(mockController);
}

- (void)testAuthorizationURL
{
    EXP_expect([self.authVC1 authorizationURL]).
}

@end
