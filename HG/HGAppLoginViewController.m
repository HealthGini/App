//
//  HGAppLoginViewController.m
//  HG
//
//  Created by Souvik Ray on 12/22/13.
//  Copyright (c) 2013 com.hg. All rights reserved.
//

#import "HGAppLoginViewController.h"
#import "HGAppDelegate.h"
#import "API.h"

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

// Displays the user's name and profile picture so they are aware of the Facebook
// identity they are logged in as.
// FB id and autoincrement UID
- (void)registerUser {
    if (FBSession.activeSession.isOpen) {
        NSLog(@"Active FB session.");
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 //self.userNameLabel.text = user.name;
                 //self.userProfileImage.profileID = [user objectForKey:@"id"];
                 NSString* command = @"loginFB";
                 NSString* fid = [user objectForKey:@"id"];
                 NSString* funame = [user objectForKey:user.name];
                 NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: command, @"command", fid, @"fid", funame, @"funame", nil];
                 [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
                     //result returned
                     NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                     if ([json objectForKey:@"error"]==nil && [res objectForKey:@"fid"]) {
                         NSLog(@"Success Login.");
                     } else {
                         //error
                         NSLog(@"Error Login.");
                     }
                 }];
             }
         }];
    }
}

- (IBAction)fbLogIn:(id)sender {
    //[self.spinner startAnimating];
    
    HGAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
    NSLog(@"Success Login here.");
   // [self registerUser]; //Added Souvik
}

//nosocial label
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if(touch.view.tag == 1000){
        [self performSegueWithIdentifier:@"seguetonewacct" sender:self];
    }
}

- (IBAction)genLogIn:(id)sender {
    [self performSegueWithIdentifier:@"seguetologinview" sender:self];
}

- (IBAction)learnMore:(id)sender {
    
}

- (void)NewAcctViewControllerDidCancel:
(HGNewAcctViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)AcctLoginControllerDidCancel:
(HGAcctLoginViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"seguetonewacct"])
	{
		HGNewAcctViewController *newAcctViewController =
        segue.destinationViewController;
		newAcctViewController.delegate = self;
	}
    else if ([segue.identifier isEqualToString:@"seguetologinview"])
	{
		HGAcctLoginViewController *acctLoginViewController =
        segue.destinationViewController;
		acctLoginViewController.delegate = self;
	}
}

@end
