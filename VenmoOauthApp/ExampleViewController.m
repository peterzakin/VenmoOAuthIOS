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
    VENAuthViewController *authVC = [VENClient OAuthViewControllerWithClientID:@"bla" clientSecret:@"bla" scopes:[NSSet setWithArray:@[@"bla"]] responseType:@"bla" redirectURL:[NSURL URLWithString:@"http://bla.com"] delegate:self];
    [self presentViewController:(UIViewController *)authVC animated:YES completion:nil];
}

@end
