#import "VENSpecBase.h"
#import "VENClient.h"


SpecBegin(VENClient)

describe(@"VENClient public header methods", ^{
    it(@"should make a shared client", ^{
        VENClient *client = [VENClient sharedClient];
        EXP_expect(client).toNot.beNil;
        VENClient *client2 = [VENClient sharedClient];
        EXP_expect(client).to.equal(client2);
    });

    it(@"should be initialized with the right parameters", ^{
        
    });
});

SpecEnd

//@interface VENClientTests : XCTestCase
//
//@end
//
//@implementation VENClientTests
//
//- (void)setUp
//{
//    [super setUp];
//    // Put setup code here; it will be run once, before the first test case.
//}
//
//- (void)tearDown
//{
//    // Put teardown code here; it will be run once, after the last test case.
//    [super tearDown];
//}
//
//- (void)testWebViewLoad
//{
//
//}
//
//- (void)testOAuthViewControllerWithClientID
//{
//    NSSet *scopes = [NSSet setWithArray:@[@"make_payments"]];
//    VENResponseType responseType = VENResponseTypeCode;
//    NSURL *redirectURL = [NSURL URLWithString:REDIRECT_URL];
//
//    UIViewController <VENAuthViewControllerDelegate> *mockController =
//    mockObjectAndProtocol([UIViewController class], @protocol(VENAuthViewControllerDelegate));
//
//    VENAuthViewController *authVC = [VENClient OAuthViewControllerWithClientID:CLIENT_ID
//                                                                  clientSecret:CLIENT_SECRET
//                                                                        scopes:scopes
//                                                                  responseType:responseType
//                                                                   redirectURL:redirectURL
//                                                                      delegate:mockController];
//    [authVC viewDidLoad];
//    assertThat(CLIENT_ID, equalTo(authVC.clientId));
//    assertThat(CLIENT_SECRET, equalTo(authVC.clientSecret));
//    assert([scopes isEqualToSet:authVC.scopes]);
//    assert(responseType == authVC.responseType);
//    assertThat(redirectURL, equalTo(authVC.redirectURL));
//    assertThat(authVC.webView, notNilValue());
//    
//    
//}
//
//
//@end
