//
//  HGAppViewController.m
//  HG
//
//  Created by Souvik Ray on 12/4/13.
//  Copyright (c) 2013 com.hg. All rights reserved.
//

#import "HGAppViewController.h"

@interface HGAppViewController ()

@end

@implementation HGAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSTimer *myTimer = [NSTimer timerWithTimeInterval:3.0
                                               target:self
                                             selector:@selector(timerFiredMethod:)
                                             userInfo:nil
                                              repeats: NO];
    
    [[NSRunLoop mainRunLoop] addTimer: myTimer
                              forMode: NSDefaultRunLoopMode];

}

- (void)timerFiredMethod:(NSTimer *)timer
{
    // Whatever the segue is called to your second view controller. Don't forget to set it in your storyboard ;)
    //[self performSegueWithIdentifier:@"seguetologinview" sender:self];
    [self performSegueWithIdentifier:@"seguetest" sender:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
