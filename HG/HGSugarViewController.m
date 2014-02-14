//
//  HGSugarViewController.m
//  HG
//
//  Created by Souvik Ray on 1/7/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import "HGSugarViewController.h"
#import "API.h"

@interface HGSugarViewController ()

@end

@implementation HGSugarViewController
@synthesize picker;
@synthesize callerView;
@synthesize bpValue;

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
    picker.delegate=self;
    picker.dataSource=self;
     _bpvalueArray = [NSMutableArray arrayWithCapacity:300];
    for ( int i = 1 ; i <= 300 ; i ++ )
        [_bpvalueArray addObject:[[NSNumber numberWithInt:i] stringValue]];
    _bptypeArray = @[@"Fasting",@"2-hour postprandial",@"Random",@"Oral",@"Glycohemoglobin A1c"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (int) numberOfColumnsInPickerView:(UIPickerView*)picker
{
    
}

- (int) pickerView:(UIPickerView*)picker numberOfRowsInColumn:(int)col
{
    
}*/

#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //return [itemsArray count];
    //set number of rows
    
    if(component== 0)
    {
        return [self.bpvalueArray count];
    }
    else
    {
        return [self.bptypeArray count];
    }
}

#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //return [itemsArray objectAtIndex:row];
    if(component == 0)
    {
        return [self.bpvalueArray objectAtIndex:row];
    }
    else
    {
        return [self.bptypeArray objectAtIndex:row];
    }
}

- (void)logRecord:(NSString*)uid setvalue:(NSString*)uval {

    NSString* command = @"postPHR";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: command, @"command", uid, @"uid", uval, @"value",nil];
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
    //result returned
    NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
    //Handle registration and login response
    if ([json objectForKey:@"error"]==nil && [res objectForKey:@"trans_uid"]) {
        NSLog(@"Success Storing new sugar record.");
        //[[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isLoggedIn"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        //error
        NSLog(@"Error Storing new sugar record.");
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"New entry could not be stored"
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles: nil] show];
    }
}];
}

- (void)dismantleView {
    [self.navigationController popViewControllerAnimated:YES];
}


//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Let's print in the console what the user had chosen;
    //NSLog(@"Chosen item: %@", [itemsArray objectAtIndex:row]);
    self.bpValue=[(NSNumber *)[_bpvalueArray objectAtIndex:row] intValue];
    NSLog(@"Chosen item: %i", self.bpValue);
}

- (IBAction)doDoneButton:(id)sender {
    
    //static NSString *CellIdentifier = @"sugarrecord";
    //UITableViewCell *cell = [callerView.tableView dequeueReusableCellWithIdentifier:<#(NSString *)#> forIndexPath:<#(NSIndexPath *)#> :CellIdentifier forIndexPath:0];
    callerView.sugarrecord.text = @"new sugar record added";
    //Store in db
    NSString* uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    [self logRecord:uid setvalue:[NSString stringWithFormat:@"%d",self.bpValue]];
    [self dismantleView];
    
}

@end
