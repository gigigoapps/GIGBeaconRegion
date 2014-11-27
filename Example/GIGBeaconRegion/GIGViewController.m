//
//  GIGViewController.m
//  GIGBeaconRegion
//
//  Created by Alejandro Rupérez on 27/11/14.
//  Copyright (c) 2014 Gigigo. All rights reserved.
//

#import "GIGViewController.h"

#import "GIGPresenter.h"

#import "GIGBeaconCell.h"


@interface GIGViewController ()
<GIGPresenterViewController>

@property (strong, nonatomic) NSArray *beaconModels;
@property (strong, nonatomic) GIGPresenter *presenter;

@end


@implementation GIGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.presenter = [[GIGPresenter alloc] initWithViewController:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.presenter viewIsReady];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - UITableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.beaconModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GIGBeaconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    [cell setBeaconModel:self.beaconModels[indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self.presenter userDidSelectBeacon:self.beaconModels[indexPath.row]];
}

#pragma mark - GIGPresenterViewController

- (void)showBeaconModels:(NSArray *)beaconModels
{
    self.beaconModels = beaconModels;

    [self.tableView reloadData];
}

@end
