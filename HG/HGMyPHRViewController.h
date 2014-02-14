//
//  HGMyPHRViewController.h
//  HG
//
//  Created by Souvik Ray on 1/18/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGMyPHRViewController : UITableViewController

- (IBAction)myplus:(id)sender;
- (IBAction)done:(id)sender;
@property (nonatomic, strong) IBOutlet UILabel *sugarrecord;
@property (nonatomic, strong) IBOutlet UILabel *cholrecord;
@property (nonatomic, strong) IBOutlet UILabel *bprecord;

@end
