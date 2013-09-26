#import "ExampleViewController.h"
#import "VENLoginViewController.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInButtonAction:(id)sender {
    VENLoginViewController *loginVC = [[VENLoginViewController alloc] initWithClientId:CLIENT_ID clientSecret:CLIENT_SECRET scopes:SCOPES reponseType:VENResponseTypeToken redirectURL:REDIRECT_URL delegate:self];
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - VENAuthViewControllerDelegate

- (void)loginViewController:(VENLoginViewController *)loginViewController finishedWithAccessToken:(NSString *)accessToken error:(NSError *)error
{
    [loginViewController dismissViewControllerAnimated:YES completion:nil];
    [[self accessTokenLabel] setText:accessToken];
}

@end
