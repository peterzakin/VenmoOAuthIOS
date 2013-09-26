#import <UIKit/UIKit.h>

#import "VENLoginViewController.h"
#import "VENClient.h"

@interface ExampleViewController : UIViewController <VENLoginViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *accessTokenLabel;

@end
