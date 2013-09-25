#import "VENDefines.h"
#import "VENAuthViewController.h"

@interface VENAuthViewController ()

@property (weak, nonatomic) id<VENAuthViewControllerDelegate> delegate;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString* clientId;
@property (strong, nonatomic) NSString* clientSecret;
@property (assign, nonatomic) VENAccessScope scopes;
@property (assign, nonatomic) VENResponseType responseType;
@property (strong, nonatomic) NSURL *redirectURL;

+ (NSString *)stringForResponseType:(VENResponseType)responseType;

+ (NSString *)stringForScopes:(VENAccessScope)scopes;

- (NSURL *)authorizationURL;

- (id)initWithClientId:(NSString *)clientId
          clientSecret:(NSString *)clientSecret
                scopes:(VENAccessScope)scopes
           reponseType:(VENResponseType)responseType
           redirectURL:(NSURL *)redirectURL
              delegate:(id<VENAuthViewControllerDelegate>)delegate;


@end

