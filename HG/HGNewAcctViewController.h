//
//  HGNewAcctViewController.h
//  HG
//
//  Created by Souvik Ray on 2/3/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class HGNewAcctViewController;

@protocol NewAcctViewControllerDelegate <NSObject>
- (void)NewAcctViewControllerDidCancel:
(HGNewAcctViewController *)controller;
@end

@interface HGNewAcctViewController : UITableViewController
@property (nonatomic, weak) id <NewAcctViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)create:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (nonatomic, strong) IBOutlet UITextView *name;
@property (strong, nonatomic) IBOutlet UITextField *passwd;
@property (strong, nonatomic) IBOutlet UIButton *createbutton;

@end
