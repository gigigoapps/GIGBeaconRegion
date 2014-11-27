//
//  GIGBeaconRegion.m
//  GIGBeaconRegion
//
//  Created by Alejandro Rupérez on 27/11/14.
//  Copyright (c) 2014 Gigigo. All rights reserved.
//  Source https://github.com/sandeepmistry/AnyiBeacon-iOS
//

#import "GIGBeaconRegion.h"

struct ClientRegion
{
    BOOL identifier[512];
    int type;
    bool notifyOnEntry;
    bool notifyOnExit;
    union
    {
        struct
        {
            BOOL proximityUUID[512];
            unsigned short major;
            unsigned short minor;
            int definitionMask;
            bool notifyEntryStateOnDisplay;
        } beaconAttributes;
        struct
        {
            struct
            {
                double latitude;
                double longitude;
            } center;
            double radius;
            double desiredAccuracy;
        } circularAttributes;
    };
};

@interface CLBeaconRegion (Hidden)

- (instancetype)initWithIdentifier:(NSString *)identifier;
- (struct ClientRegion)clientRegion;

@end

@implementation GIGBeaconRegion

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    return (self = [super initWithIdentifier:identifier]);
}

- (struct ClientRegion)clientRegion
{
    struct ClientRegion clientRegion = [super clientRegion];

    clientRegion.beaconAttributes.definitionMask = ~0x07;

    return clientRegion;
}

@end
