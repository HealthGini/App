//
//  HGAppAppDelegate.m
//  HG
//
//  Created by Souvik Ray on 12/4/13.
//  Copyright (c) 2013 com.hg. All rights reserved.
//

#import "HGAppDelegate.h"
#import "HGBaseViewController.h"
#import "HGAppLoginViewController.h"
#import <FacebookSDK/FBSessionTokenCachingStrategy.h>
#import "API.h"

@implementation HGAppDelegate

@synthesize window = _window,
navigationController = _navigationController,
mainViewController = _mainViewController,
loginViewController = _loginViewController,
isNavigating = _isNavigating;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Facebook SDK * login flow *
    // Attempt to handle URLs to complete any auth (e.g., SSO) flow.
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call) {
        // Facebook SDK * App Linking *
        // For simplicity, this sample will ignore the link if the session is already
        // open but a more advanced app could support features like user switching.
        if (call.accessTokenData) {
            if ([FBSession activeSession].isOpen) {
                NSLog(@"INFO: Ignoring app link because current session is open.");
            }
            else {
                [self handleAppLink:call.accessTokenData];
            }
        }
    }];
}

// Helper method to wrap logic for handling app links.
- (void)handleAppLink:(FBAccessTokenData *)appLinkToken {
    // Initialize a new blank session instance...
    FBSession *appLinkSession = [[FBSession alloc] initWithAppID:nil
                                                     permissions:nil
                                                 defaultAudience:FBSessionDefaultAudienceNone
                                                 urlSchemeSuffix:nil
                                              tokenCacheStrategy:[FBSessionTokenCachingStrategy nullCacheInstance] ];
    [FBSession setActiveSession:appLinkSession];
    // ... and open it from the App Link's Token.
    [appLinkSession openFromAccessTokenData:appLinkToken
                          completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                              // Forward any errors to the FBLoginView delegate.
                              if (error) {
                                  [self.loginViewController loginView:nil handleError:error];
                              }
                          }];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //[[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:(160/255.0) green:(97/255.0) blue:(5/255.0) alpha:1]];
    [[UINavigationBar appearance] setTintColor:Rgb2UIColor(160, 97, 5)];
    
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.mainViewController=[stryBoard instantiateViewControllerWithIdentifier:@"baseview"];
    self.navigationController=[[UINavigationController alloc]
                               initWithRootViewController:self.mainViewController];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    
    // Facebook SDK * pro-tip *
    // We take advantage of the `FBLoginView` in our loginViewController, which can
    // automatically open a session if there is a token cached. If we were not using
    // that control, this location would be a good place to try to open a session
    // from a token cache.
    
    // See if the app has a valid token for the current state.
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // To-do, show logged in view
        NSLog(@"Active FB Session.");
        [self showLoggedinView];
        //[self openSession];
    } else if ([[NSUserDefaults standardUserDefaults] valueForKey:@"isLoggedIn"] )
    {
        [self showLoggedinView];
    }
    else
    {
        // No, display the login page.
        NSLog(@"NonActive FB Session.");
        [self showLoginView];
    }

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showLoggedinView
{
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *topViewController = [self.navigationController topViewController];
    
    HGBaseViewController* baseViewController=[stryBoard instantiateViewControllerWithIdentifier:@"baseview"];
     [topViewController presentModalViewController:baseViewController animated:NO];
    
    /*SplashViewController* splashViewController=[stryBoard instantiateViewControllerWithIdentifier:@"splashview"];
    [topViewController presentModalViewController:splashViewController animated:NO];*/
}

- (void)showLoginView
{
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *topViewController = [self.navigationController topViewController];
    
    HGAppLoginViewController* loginViewController=[stryBoard instantiateViewControllerWithIdentifier:@"loginview"];
    [topViewController presentModalViewController:loginViewController animated:NO];
}


- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            NSLog(@"FBSessionStateOpen.");
            
            NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
            if ([settings objectForKey:@"uname"]==nil) {
                
            //Register the user
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                 if (!error) {
                     NSString* fid = [user objectForKey:@"id"];
                     NSString* funame = [user objectForKey:@"username"];
                     NSLog(@"FBSessionStateOpen: username = %@",funame);
                     NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                     [settings setObject:funame forKey:@"uname"];
                     //[settings setObject:fid forKey:@"userid"];
                     [settings synchronize];
                     //[self registerTheDevice];
                     
                     [self registerUser:funame setpasswd:@"social_passwd" setlogintype:@"facebook"];
                 }
             }];
                
            }
            
            UIViewController *topViewController =
            [self.navigationController topViewController];
            if ([[topViewController modalViewController]
                 isKindOfClass:[HGAppLoginViewController class]]) {
                [topViewController dismissModalViewControllerAnimated:YES];
            }
            
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            NSLog(@"FBSessionStateClosed.");
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            //[FBSession.activeSession close];
            //[FBSession setActiveSession:nil];
            
            [self showLoginView];
            break;
        default:
            NSLog(@"Default FB State.");
            break;
    }
    
    if (error) {
        NSLog(@"FB State error.");
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


//pass fb id to backend ?
- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

- (void)registerUser:(NSString*)uname setpasswd:(NSString*)upasswd setlogintype:(NSString*)ltype{
    
    NSString* command = @"register";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: command, @"command", uname, @"uname", upasswd, @"upasswd", ltype, @"ltype", nil];
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
        //result returned
        NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
        if ([json objectForKey:@"error"]==nil && [res objectForKey:@"fid"]) {
            NSLog(@"Success Login.");
        } else {
            //error
            NSLog(@"Error Login.");
        }
    }];
}

@end
