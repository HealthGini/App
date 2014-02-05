//
//  HGAppAppDelegate.h
//  HG
//
//  Created by Souvik Ray on 12/4/13.
//  Copyright (c) 2013 com.hg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

//modified

@class HGAppViewController;
@class HGAppLoginViewController;
@class HGBaseViewController;
@class SplashViewController;

@interface HGAppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) HGBaseViewController *mainViewController;
@property (strong, nonatomic) HGAppLoginViewController* loginViewController;
@property (strong, nonatomic) UIWindow *window;
@property BOOL isNavigating;

- (void)openSession;

@end
