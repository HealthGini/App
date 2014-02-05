//
//  HGAppLoginViewController.h
//  HG
//
//  Created by Souvik Ray on 12/22/13.
//  Copyright (c) 2013 com.hg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface HGAppLoginViewController : UIViewController<FBLoginViewDelegate,FBUserSettingsDelegate, UIAlertViewDelegate,UITextFieldDelegate>

- (IBAction)fbLogIn:(id)sender;
- (IBAction)genLogIn:(id)sender;
- (IBAction)learnMore:(id)sender;


@end
