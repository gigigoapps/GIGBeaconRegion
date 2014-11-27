//
//  GIGBeaconModel.h
//  GIGBeaconRegion
//
//  Created by Alejandro Rupérez on 27/11/14.
//  Copyright (c) 2014 Gigigo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>


@interface GIGBeaconModel : NSObject

@property (readonly, nonatomic, strong) NSString *alias;
@property (readonly, nonatomic, strong) NSString *proximityUUID;

@property (readonly, nonatomic, strong) NSString *major;
@property (readonly, nonatomic, strong) NSString *minor;

@property (readonly, nonatomic, strong) NSString *accuracy;
@property (readonly, nonatomic, strong) UIColor *color;

@property (readonly, nonatomic, strong) NSString *proximity;
@property (readonly, nonatomic, strong) NSString *rssi;


+ (NSArray *)beaconModelsWithBeacons:(NSArray *)beacons;

+ (instancetype)beaconModelWithBeacon:(CLBeacon *)beacon;

@end
