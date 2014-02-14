//
//  HGAcctLoginViewController.m
//  HG
//
//  Created by Souvik Ray on 2/4/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import "HGAcctLoginViewController.h"
#import "API.h"

@interface HGAcctLoginViewController ()

@end

@implementation HGAcctLoginViewController

@synthesize delegate;
@synthesize email;
@synthesize passwd;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)loginUser:(NSString*)uname setpasswd:(NSString*)upasswd {
    
    NSString* command = @"login";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: command, @"command", uname, @"uname", upasswd, @"upasswd",nil];
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
        //result returned
        NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
        //Handle registration and login response
        if ([json objectForKey:@"error"]==nil && [res objectForKey:@"uid"]) {
            NSLog(@"Success Login.");
            //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            UIViewController *parentview = self.presentingViewController;
            [self dismissViewControllerAnimated:NO completion:^{
                [parentview dismissViewControllerAnimated:NO completion:nil];
            }];
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isLoggedIn"];
            //Also store the uid of current user
            NSInteger uid = [(NSNumber*)[res objectForKey:@"uid"] intValue];
            [[NSUserDefaults standardUserDefaults] setInteger:uid forKey:@"uid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } else {
            //error
            NSLog(@"Error Login.");
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:@"Username/password incorrect! Try again!"
                                       delegate:nil
                              cancelButtonTitle:@"Close"
                              otherButtonTitles: nil] show];
        }
    }];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate AcctLoginControllerDidCancel:self];
}

- (IBAction)login:(id)sender
{
    NSString* uname = self.email.text;
    NSString* upasswd = self.passwd.text;
    [self loginUser:uname setpasswd:upasswd];
}

@end
