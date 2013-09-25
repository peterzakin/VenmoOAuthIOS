//
//  ExampleViewController.h
//  VenmoOAuthIOS
//
//  Created by Ben Guo on 9/24/13.
//  Copyright (c) 2013 Venmo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VENLoginViewController.h"

@interface ExampleViewController : UIViewController <VENLoginViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *accessTokenLabel;

@end
