#import "AppDelegate.h"
#import "ExampleViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ExampleViewController *exampleViewController = [[ExampleViewController alloc] initWithNibName:@"ExampleViewController" bundle:nil];
    self.window.rootViewController = exampleViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
