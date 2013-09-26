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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)logInButtonAction:(id)sender {
    VENLoginViewController *loginVC = [[VENLoginViewController alloc] initWithClientId:CLIENT_ID clientSecret:CLIENT_SECRET scopes:SCOPES reponseType:VENResponseTypeToken redirectURL:REDIRECT_URL delegate:self];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (IBAction)testButtonAction:(id)sender {
    if (self.client) {
        [self.client getPath:@"/me"
                  parameters:nil
           completionHandler:^(NSURLResponse *response, NSDictionary *json, NSError *connectionError) {
               if (json) {
                   self.textView.text = [json description];
               } else {
                   self.textView.text = [connectionError debugDescription];
               }
        }];
    }
}

- (void)updateTextView:(NSDictionary *)json
{
    self.textView.text = [json description];
}

#pragma mark - VENAuthViewControllerDelegate

- (void)loginViewController:(VENLoginViewController *)loginViewController finishedWithAccessToken:(NSString *)accessToken error:(NSError *)error
{
    [loginViewController dismissViewControllerAnimated:YES completion:nil];
    [[self accessTokenLabel] setText:accessToken];
    self.client = [[VENClient alloc] initWithAccessToken:accessToken];
}

@end
