#import "VENSpecBase.h"
#import "VENAuthViewController_Internal.h"

SpecBegin(VENAuthViewController)

describe(@"VENAuthViewController stringForResponseType:", ^{
    it(@"should return the right string given a response type", ^{
        NSString *s = [VENAuthViewController stringForResponseType:VENResponseTypeToken];
        EXP_expect(s).to.equal(@"token");
        NSString *s2 = [VENAuthViewController stringForResponseType:0];
        EXP_expect(s2).to.equal(@"token");
        NSString *s3 = [VENAuthViewController stringForResponseType:VENResponseTypeCode];
        EXP_expect(s3).to.equal(@"code");
    });
});

describe(@"VENAuthViewController initialization", ^{
    it(@"should be initialized with correct parameters", ^{
        UIViewController <VENAuthViewControllerDelegate> *mockController = mockObjectAndProtocol([UIViewController class], @protocol(VENAuthViewControllerDelegate));

        VENAuthViewController *authVC = [[VENAuthViewController alloc] initWithClientId:CLIENT_ID
                                                                           clientSecret:CLIENT_SECRET
                                                                                 scopes:SCOPES
                                                                            reponseType:VENResponseTypeToken
                                                                            redirectURL:REDIRECT_URL
                                                                               delegate:mockController];
        EXP_expect(authVC.clientId).to.equal(CLIENT_ID);
        EXP_expect(authVC.clientSecret).to.equal(CLIENT_SECRET);
        EXP_expect(authVC.scopes).to.equal(SCOPES);
        EXP_expect(authVC.responseType).to.equal(VENResponseTypeToken);
        EXP_expect(authVC.redirectURL).to.equal(REDIRECT_URL);
        EXP_expect(authVC.delegate).to.equal(mockController);
    });
});



SpecEnd
