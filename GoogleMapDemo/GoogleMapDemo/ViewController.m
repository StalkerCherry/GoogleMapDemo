//
//  ViewController.m
//  GoogleMapDemo
//
//  Created by leco on 2017/1/13.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import "ViewController.h"
#import "GoogleMaps/GoogleMaps.h"
#import "Samples/Samples.h"
#import "AppDelegate.h"
#import "SDKDemoAPIKey.h"

@interface ViewController ()
{
    NSArray *_demos;
    NSArray *_demoSections;
    BOOL _isPhone;
    UIPopoverController *_popover;
    UIBarButtonItem *_samplesButton;
    __weak UIViewController *_controller;
    CLLocationManager *_locationManager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    
    if (!_isPhone) {
        self.clearsSelectionOnViewWillAppear = NO;
    } else {
        UIBarButtonItem *backButton =
        [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"Back")
                                         style:UIBarButtonItemStylePlain
                                        target:nil
                                        action:nil];
        [self.navigationItem setBackBarButtonItem:backButton];
    }
    
    self.title = NSLocalizedString(@"Maps SDK Demos", @"Maps SDK Demos");
    self.title = [NSString stringWithFormat:@"%@: %@", self.title, [GMSServices SDKVersion]];
    
    self.tableView.autoresizingMask =
    UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _demoSections = [Samples loadSections];
    _demos = [Samples loadDemos];
    
    if (!_isPhone) {
        [self loadDemo:0 atIndex:0];
    }
}


#pragma mark - UITableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _demoSections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_demoSections objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *demosInSection = [_demos objectAtIndex:section];
    return [demosInSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
        
        if (_isPhone) {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
    }
    
    NSDictionary *demo = [[_demos objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [demo objectForKey:@"title"];
    cell.detailTextLabel.text = [demo objectForKey:@"description"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // The user has chosen a sample; load it and clear the selection!
    [self loadDemo:indexPath.section atIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController
     willHideViewController:(UIViewController *)viewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)popoverController {
    _popover = popoverController;
    _samplesButton = barButtonItem;
    _samplesButton.title = NSLocalizedString(@"Samples", @"Samples");
    _samplesButton.style = UIBarButtonItemStyleDone;
    [self updateSamplesButton];
}

- (void)splitViewController:(UISplitViewController *)splitController
     willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    _popover = nil;
    _samplesButton = nil;
    [self updateSamplesButton];
}

#pragma mark - Private methods

- (void)loadDemo:(NSUInteger)section atIndex:(NSUInteger)index {
    NSDictionary *demo = [[_demos objectAtIndex:section] objectAtIndex:index];
    UIViewController *controller = [[[demo objectForKey:@"controller"] alloc] init];
    _controller = controller;
    
    if (controller != nil) {
        controller.title = [demo objectForKey:@"title"];
        
        if (_isPhone) {
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            [self.appDelegate setSample:controller];
            [_popover dismissPopoverAnimated:YES];
        }
        
        [self updateSamplesButton];
    }
}

- (void)updateSamplesButton {
    _controller.navigationItem.leftBarButtonItem = _samplesButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end