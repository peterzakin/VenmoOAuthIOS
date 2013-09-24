#import "VENDefines.h"
#import "VENAuthViewController.h"

@interface VENAuthViewController ()

@property (weak, nonatomic) id<VENAuthViewControllerDelegate> delegate;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString* clientId;
@property (strong, nonatomic) NSString* clientSecret;
@property (strong, nonatomic) NSSet *scopes;
@property (assign, nonatomic) VENResponseType responseType;
@property (strong, nonatomic) NSURL *redirectURL;

@end

