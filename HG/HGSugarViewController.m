//
//  HGSugarViewController.m
//  HG
//
//  Created by Souvik Ray on 1/7/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import "HGSugarViewController.h"

@interface HGSugarViewController ()

@end

@implementation HGSugarViewController
@synthesize picker;
@synthesize callerView;

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


//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Let's print in the console what the user had chosen;
    //NSLog(@"Chosen item: %@", [itemsArray objectAtIndex:row]);
}

- (IBAction)doDoneButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //static NSString *CellIdentifier = @"sugarrecord";
    //UITableViewCell *cell = [callerView.tableView dequeueReusableCellWithIdentifier:<#(NSString *)#> forIndexPath:<#(NSIndexPath *)#> :CellIdentifier forIndexPath:0];
    callerView.sugarrecord.text = @"new sugar record added";
}

@end
