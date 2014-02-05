//
//  HGBaseViewController.m
//  HG
//
//  Created by Souvik Ray on 1/22/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import "HGBaseViewController.h"

@interface HGBaseViewController ()

@end

@implementation HGBaseViewController

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
    self.navigationController.navigationBarHidden = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
