//
//  GIGBeaconModel.m
//  GIGBeaconRegion
//
//  Created by Alejandro Rupérez on 27/11/14.
//  Copyright (c) 2014 Gigigo. All rights reserved.
//

#import "GIGBeaconModel.h"

#import "GIGStorage.h"


@implementation GIGBeaconModel

+ (NSArray *)beaconModelsWithBeacons:(NSArray *)beacons
{
    NSMutableArray *beaconModels = [[NSMutableArray alloc] initWithCapacity:beacons.count];

    for (CLBeacon *beacon in beacons)
    {
        GIGBeaconModel *beaconModel = [self beaconModelWithBeacon:beacon];
        if (beaconModels)
        {
            [beaconModels addObject:beaconModel];
        }
    }

    return beaconModels;
}

+ (instancetype)beaconModelWithBeacon:(CLBeacon *)beacon
{
    return [[self alloc] initWithBeacon:beacon];
}

#pragma mark - INIT

- (instancetype)initWithBeacon:(CLBeacon *)beacon
{
    self = [beacon isKindOfClass:[CLBeacon class]] ? [super init] : nil;

    if (self)
    {
        [self setProximityUUID:beacon.proximityUUID];
        [self setMajor:beacon.major];
        [self setMinor:beacon.minor];
        [self setProximity:beacon.proximity];
        [self setAccuracy:beacon.accuracy];
        [self setRssi:beacon.rssi];
    }

    return self;
}

#pragma mark - PRIVATE

- (void)setProximityUUID:(NSUUID *)proximityUUID
{
    _proximityUUID = proximityUUID.UUIDString;

    _alias = [[GIGStorage sharedStorage] objectForKey:_proximityUUID];
    if (!_alias)
    {
        _alias = _proximityUUID;
    }
}

- (void)setMajor:(NSNumber *)major
{
    _major = [NSString stringWithFormat:@"Major: %@", [major stringValue]];
}

- (void)setMinor:(NSNumber *)minor
{
    _minor = [NSString stringWithFormat:@"Minor: %@", [minor stringValue]];
}

- (void)setAccuracy:(CLLocationAccuracy)accuracy
{
    if (accuracy > 0.0f)
    {
        _accuracy = [NSString stringWithFormat:@"%.2fm", accuracy];

        float alpha = 1.0f - MIN(accuracy / 3.0f, 0.9f);
        _color = [UIColor colorWithRed:0.145f green:0.749f blue:0.6f alpha:alpha];
    }
    else
    {
        _accuracy = @"";

        _color = [UIColor clearColor];
    }
}

- (void)setProximity:(CLProximity)proximity
{
    switch (proximity)
    {
        case CLProximityImmediate:
            _proximity = @"Immediate";
            break;
        case CLProximityNear:
            _proximity = @"Near";
            break;
        case CLProximityFar:
            _proximity = @"Far";
            break;
        default:
            _proximity = @"Unknown";
            break;
    }
}

- (void)setRssi:(NSInteger)rssi
{
    _rssi = [NSString stringWithFormat:@"%lddB", (long)rssi];
}

@end
