//
//  AppDelegate.m
//  GoogleMapDemo
//
//  Created by leco on 2017/1/13.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import "AppDelegate.h"

#import "GoogleMaps/GoogleMaps.h"
#import "ViewController.h"
#import "SDKDemoAPIKey.h"

@interface AppDelegate ()
{
    id _services;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([kAPIKey length] == 0) {
        // Blow up if APIKey has not yet been set.
        NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
        NSString *format = @"Configure APIKey inside SDKDemoAPIKey.h for your "
        @"bundle `%@`, see README.GoogleMapsDemos for more information";
        @throw [NSException exceptionWithName:@"DemoAppDelegate"
                                       reason:[NSString stringWithFormat:format, bundleId]
                                     userInfo:nil];
    }
    [GMSServices provideAPIKey:kAPIKey];
    _services = [GMSServices sharedServices];
    
    NSLog(@"Open source licenses:\n%@", [GMSServices openSourceLicenseInfo]);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *master = [[ViewController alloc] init];
    master.appDelegate = self;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:master];
        
        self.navigationController.navigationBar.translucent = NO;
        
        self.window.rootViewController = self.navigationController;
        
    } else {
        
        UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:master];
        
        UIViewController *empty = [[UIViewController alloc] init];
        UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:empty];
        
        detailNavigationController.navigationBar.translucent = NO;
        
        self.splitViewController = [[UISplitViewController alloc] init];
        self.splitViewController.delegate = master;
        self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
        self.splitViewController.presentsWithGesture = NO;
        
        self.window.rootViewController = self.splitViewController;
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setSample:(UIViewController *)sample {
    
    NSAssert([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad,
             @"Expected device to be iPad inside setSample:");
    
    // Finds the UINavigationController in the right side of the sample, and
    // replace its displayed controller with the new sample.
    UINavigationController *nav = [self.splitViewController.viewControllers objectAtIndex:1];
    [nav setViewControllers:[NSArray arrayWithObject:sample] animated:NO];
}

- (UIViewController *)sample {
    
    NSAssert([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad,
             @"Expected device to be iPad inside sample");
    
    // The current sample is the top-most VC in the right-hand pane of the
    // splitViewController.
    UINavigationController *nav = [self.splitViewController.viewControllers objectAtIndex:1];
    return [[nav viewControllers] objectAtIndex:0];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
