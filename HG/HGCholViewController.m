//
//  HGCholViewController.m
//  HG
//
//  Created by Souvik Ray on 2/13/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import "HGCholViewController.h"
#import "API.h"

@interface HGCholViewController ()

@end

@implementation HGCholViewController
@synthesize picker;
@synthesize cholTotalvalueArray;
@synthesize cholLDLvalueArray;
@synthesize cholHDLvalueArray;
@synthesize cholTrivalueArray;

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
    cholTotalvalueArray = [NSMutableArray arrayWithCapacity:500];
    for ( int i = 1 ; i <= 500 ; i ++ )
        [cholTotalvalueArray addObject:[[NSNumber numberWithInt:i] stringValue]];
    cholLDLvalueArray = [NSMutableArray arrayWithCapacity:500];
    for ( int i = 1 ; i <= 500 ; i ++ )
        [cholLDLvalueArray addObject:[[NSNumber numberWithInt:i] stringValue]];
    cholHDLvalueArray = [NSMutableArray arrayWithCapacity:500];
    for ( int i = 1 ; i <= 500 ; i ++ )
        [cholHDLvalueArray addObject:[[NSNumber numberWithInt:i] stringValue]];
    cholTrivalueArray = [NSMutableArray arrayWithCapacity:500];
    for ( int i = 1 ; i <= 500 ; i ++ )
        [cholTrivalueArray addObject:[[NSNumber numberWithInt:i] stringValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //return [itemsArray count];
    //set number of rows
    
    if(component== 0)
    {
        return [self.cholTotalvalueArray count];
    }
    else if(component == 1)
    {
        return [self.cholLDLvalueArray count];
    }
    else if(component == 2)
    {
        return [self.cholHDLvalueArray count];
    }
    else
    {
        return [self.cholTrivalueArray count];
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
        return [self.cholTotalvalueArray objectAtIndex:row];

    }
    else if(component == 1)
    {
        return [self.cholLDLvalueArray objectAtIndex:row];
    }
    else if(component == 2)
    {
        return [self.cholHDLvalueArray objectAtIndex:row];
    }
    else
    {
        return [self.cholTrivalueArray objectAtIndex:row];
    }
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Let's print in the console what the user had chosen;
    //NSLog(@"Chosen item: %@", [itemsArray objectAtIndex:row]);
    if(component==0){
        _cholTotalValue=[(NSNumber *)[cholTotalvalueArray objectAtIndex:row] intValue];
        NSLog(@"Chosen item: %i", _cholTotalValue);
    }

    else if(component==1)
        _cholLDLValue=[(NSNumber *)[cholLDLvalueArray objectAtIndex:row] intValue];
    else if(component==2)
        _cholHDLValue=[(NSNumber *)[cholHDLvalueArray objectAtIndex:row] intValue];
    else
        _cholTriValue=[(NSNumber *)[cholTrivalueArray objectAtIndex:row] intValue];
    
}

- (IBAction)doDoneButton:(id)sender {
    
    //static NSString *CellIdentifier = @"sugarrecord";
    //UITableViewCell *cell = [callerView.tableView dequeueReusableCellWithIdentifier:<#(NSString *)#> forIndexPath:<#(NSIndexPath *)#> :CellIdentifier forIndexPath:0];
    _callerView.cholrecord.text = @"new cholesterol record added";
    //Store in db
    NSString* uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    //[self logRecord:uid setvalue:[NSString stringWithFormat:@"%d",self.bpValue]];
    [self dismantleView];
    
}

- (void)dismantleView {
    [self.navigationController popViewControllerAnimated:YES];
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

@end
