//
//  AppDelegate.m
//  GEmap
//
//  Created by manman'swork on 17/2/21.
//  Copyright © 2017年 manman'swork. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MasterViewController.h"

static NSString *const kAPIKey = @"AIzaSyC7NsImh4ibV6y6t5accPQNvcJKKQBNA3c";

@interface AppDelegate (){
    id _services;
}


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [GMSServices provideAPIKey:@"AIzaSyAleSTvh3HFWKnUFgJStps-nxw3opQARaw"];
    
    

    
    
    
    
    
    /*
    if (kAPIKey.length == 0) {
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
    */
    
    
    
    
    
//    // Log the required open source licenses! Yes, just NSLog-ing them is not enough but is good for
//    // a demo.
//    NSLog(@"Open source licenses:\n%@", [GMSServices openSourceLicenseInfo]);
//    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    MasterViewController *master = [[MasterViewController alloc] init];
//    master.appDelegate = self;
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        // This is an iPhone; configure the top-level navigation controller as the
//        // rootViewController, which contains the 'master' list of samples.
//        self.navigationController =
//        [[UINavigationController alloc] initWithRootViewController:master];
//        
//        // Force non-translucent navigation bar for consistency of demo between
//        // iOS 6 and iOS 7.
//        self.navigationController.navigationBar.translucent = NO;
//        
//        self.window.rootViewController = self.navigationController;
//    } else {
//        // This is an iPad; configure a split-view controller that contains the
//        // the 'master' list of samples on the left side, and the current displayed
//        // sample on the right (begins empty).
//        UINavigationController *masterNavigationController =
//        [[UINavigationController alloc] initWithRootViewController:master];
//        
//        UIViewController *empty = [[UIViewController alloc] init];
//        UINavigationController *detailNavigationController =
//        [[UINavigationController alloc] initWithRootViewController:empty];
//        
//        // Force non-translucent navigation bar for consistency of demo between
//        // iOS 6 and iOS 7.
//        detailNavigationController.navigationBar.translucent = NO;
//        
//        self.splitViewController = [[UISplitViewController alloc] init];
//        self.splitViewController.delegate = master;
//        self.splitViewController.viewControllers =
//        @[masterNavigationController, detailNavigationController];
//        self.splitViewController.presentsWithGesture = NO;
//        
//        self.window.rootViewController = self.splitViewController;
//    }
//    
//    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
