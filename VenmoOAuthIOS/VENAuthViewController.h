#import <UIKit/UIKit.h>
#import "VENDefines.h"
#import "VENClient.h"

@protocol VENAuthViewControllerDelegate;

@interface VENAuthViewController : UIViewController <UIWebViewDelegate>


@end

@protocol VENAuthViewControllerDelegate

- (void)authViewController:(VENAuthViewController *)authViewController
   finishedWithAccessToken:(NSString *)accessToken
                     error:(NSError *)error;

@end