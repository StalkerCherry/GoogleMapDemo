//
//  AppDelegate.h
//  GoogleMapDemo
//
//  Created by leco on 2017/1/13.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UISplitViewController *splitViewController;
@property (strong, nonatomic) UIViewController *sample;

@end

