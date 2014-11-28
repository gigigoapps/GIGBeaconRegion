//
//  GIGPresenter.m
//  GIGBeaconRegion
//
//  Created by Alejandro Rupérez on 27/11/14.
//  Copyright (c) 2014 Gigigo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <GIGBeaconRegion/GIGBeaconRegion.h>

#import "GIGPresenter.h"

#import "GIGStorage.h"
#import "GIGErrorFactory.h"


@interface GIGPresenter ()
<CLLocationManagerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) UIViewController<GIGPresenterViewController> *viewController;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GIGStorage *storage;

@end


@implementation GIGPresenter

- (instancetype)initWithViewController:(UIViewController<GIGPresenterViewController> *)viewController
{
    self = [super init];

    if (self)
    {
        _viewController = viewController;
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;

        _storage = [GIGStorage sharedStorage];
    }

    return self;
}

- (void)viewIsReady
{
    if ([CLLocationManager instancesRespondToSelector:NSSelectorFromString(@"requestAlwaysAuthorization")])
    {
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways)
        {
            [_locationManager requestAlwaysAuthorization];
        }
    }

    GIGBeaconRegion *beaconRegion = [[GIGBeaconRegion alloc] initWithIdentifier:@"Any"];
    [_locationManager startRangingBeaconsInRegion:beaconRegion];
}

- (void)userDidSelectBeacon:(GIGBeaconModel *)beaconModel
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alias" message:beaconModel.proximityUUID delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];

    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    if (beaconModel.alias && ![beaconModel.alias isEqualToString:beaconModel.proximityUUID])
    {
        [alertView textFieldAtIndex:0].text = beaconModel.alias;
    }

    [alertView show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex > 0)
    {
        NSString *value = [alertView textFieldAtIndex:0].text;
        if (value.length)
        {
            [self.storage setObject:value forKey:alertView.message];
        }
        else
        {
            [self.storage removeObjectForKey:alertView.message];
        }
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    [self.viewController showBeaconModels:[GIGBeaconModel beaconModelsWithBeacons:beacons]];
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:@"Error" message:[GIGErrorFactory errorWithUnderlyingError:error].localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

@end
