//
//  AppDelegate.h
//  GEmap
//
//  Created by manman'swork on 17/2/21.
//  Copyright © 2017年 manman'swork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <
UIApplicationDelegate,
UISplitViewControllerDelegate>

@property(strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) UINavigationController *navigationController;
@property(strong, nonatomic) UISplitViewController *splitViewController;

/**
 * If the device is an iPad, this property controls the sample displayed in the
 * right side of its split view controller.
 */
@property(strong, nonatomic) UIViewController *sample;




@end

