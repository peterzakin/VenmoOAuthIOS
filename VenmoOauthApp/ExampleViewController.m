//
//  ExampleViewController.m
//  VenmoOAuthIOS
//
//  Created by Ben Guo on 9/24/13.
//  Copyright (c) 2013 Venmo. All rights reserved.
//

#import "ExampleViewController.h"
#import "VENClient.h"

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
    VENClient *client = [[VENClient alloc] initWithClientID:CLIENT_ID clientSecret:CLIENT_SECRET scopes:SCOPES responseType:VENResponseTypeToken redirectURL:REDIRECT_URL delegate:self];
    [client authorize];
}

#pragma mark - VENAuthViewControllerDelegate

- (void)authViewController:(VENLoginViewController *)authViewController finishedWithAccessToken:(NSString *)accessToken error:(NSError *)error
{
    [authViewController dismissViewControllerAnimated:YES completion:nil];
    [[self accessTokenLabel] setText:accessToken];
}

@end
