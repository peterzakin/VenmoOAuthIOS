#import <UIKit/UIKit.h>

#import "VENLoginViewController.h"
#import "VENClient.h"

@interface ExampleViewController : UIViewController <VENLoginViewControllerDelegate, VENClientDelegate>

@property (weak, nonatomic) IBOutlet UILabel *accessTokenLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) VENClient *client;

@end
