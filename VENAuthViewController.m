//
//  VENAuthViewController.m
//  VenmoOAuthIOS
//
//  Created by Peter Zakin on 9/23/13.
//  Copyright (c) 2013 Venmo. All rights reserved.
//

#import "VENAuthViewController.h"
#import <UIKit/UIKit.h>

@interface VENAuthViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation VENAuthViewController

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setWebView:[[UIWebView alloc] initWithFrame:self.view.window.frame]];
    self.view = self.webView;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
