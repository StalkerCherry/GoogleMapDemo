//
//  ViewController.h
//  GoogleMapDemo
//
//  Created by leco on 2017/1/13.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface ViewController : UITableViewController <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) AppDelegate *appDelegate;

@end

