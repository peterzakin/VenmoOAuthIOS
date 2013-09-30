#import <UIKit/UIKit.h>
#import "VENDefines.h"

@protocol VENLoginViewControllerDelegate;

@interface VENLoginViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) id<VENLoginViewControllerDelegate> delegate;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString* clientId;
@property (strong, nonatomic) NSString* clientSecret;
@property (assign, nonatomic) VENAccessScope scopes;
@property (assign, nonatomic) VENResponseType responseType;
@property (strong, nonatomic) NSURL *redirectURL;
@property (strong, nonatomic) UIToolbar *toolbar;

+ (NSString *)stringForResponseType:(VENResponseType)responseType;

+ (NSString *)stringForScopes:(VENAccessScope)scopes;

- (NSURL *)authorizationURL;

- (id)initWithClientId:(NSString *)clientId
          clientSecret:(NSString *)clientSecret
                scopes:(VENAccessScope)scopes
           reponseType:(VENResponseType)responseType
           redirectURL:(NSURL *)redirectURL
              delegate:(id<VENLoginViewControllerDelegate>)delegate;

@end

@protocol VENLoginViewControllerDelegate

- (void)loginViewController:(VENLoginViewController *)loginViewController
   finishedWithAccessToken:(NSString *)accessToken
                     error:(NSError *)error;

@end