//
//  HGAcctLoginViewController.h
//  HG
//
//  Created by Souvik Ray on 2/4/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HGAcctLoginViewController;

@protocol AcctLoginControllerDelegate <NSObject>
- (void)AcctLoginControllerDidCancel:
(HGAcctLoginViewController *)controller;
@end

@interface HGAcctLoginViewController : UITableViewController
@property (nonatomic, weak) id <AcctLoginControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)login:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *passwd;

@end
