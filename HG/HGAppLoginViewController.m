//
//  HGAppLoginViewController.m
//  HG
//
//  Created by Souvik Ray on 12/22/13.
//  Copyright (c) 2013 com.hg. All rights reserved.
//

#import "HGAppLoginViewController.h"
#import "HGAppDelegate.h"

@interface HGAppLoginViewController ()

@end

@implementation HGAppLoginViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogIn:(id)sender {
    //[self.spinner startAnimating];
    
    HGAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //[appDelegate openSession];
    NSLog(@"Success Login here.");
   // [self registerUser]; //Added Souvik
}

@end
