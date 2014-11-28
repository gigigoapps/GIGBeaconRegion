//
//  GIGErrorFactory.m
//  GIGBeaconRegion
//
//  Created by Alejandro Rupérez on 28/11/14.
//  Copyright (c) 2014 alexruperez. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "GIGErrorFactory.h"

@implementation GIGErrorFactory

+ (NSError *)errorWithUnderlyingError:(NSError *)underlyingError
{
    return [NSError errorWithDomain:underlyingError.domain code:underlyingError.code userInfo:@{ NSUnderlyingErrorKey : underlyingError, NSLocalizedDescriptionKey : [self localizedDescriptionForError:underlyingError] }];
}

+ (NSString *)localizedDescriptionForError:(NSError *)error
{
    if ([error.domain isEqualToString:kCLErrorDomain])
    {
        switch (error.code)
        {
            case kCLErrorLocationUnknown:
                return @"The location manager was unable to obtain a location value right now.";
            case kCLErrorDenied:
                return @"Access to the location service was denied by the user.";
            case kCLErrorNetwork:
                return @"The network was unavailable or a network error occurred.";
            case kCLErrorHeadingFailure:
                return @"The heading could not be determined.";
            case kCLErrorRegionMonitoringDenied:
                return @"Access to the region monitoring service was denied by the user.";
            case kCLErrorRegionMonitoringFailure:
                return @"A registered region cannot be monitored.";
            case kCLErrorRegionMonitoringSetupDelayed:
                return @"Core Location could not initialize the region monitoring feature immediately.";
            case kCLErrorRegionMonitoringResponseDelayed:
                return @"Core Location will deliver events but they may be delayed.";
            case kCLErrorGeocodeFoundNoResult:
                return @"The geocode request yielded no result.";
            case kCLErrorGeocodeFoundPartialResult:
                return @"The geocode request yielded a partial result.";
            case kCLErrorGeocodeCanceled:
                return @"The geocode request was canceled.";
            case kCLErrorDeferredFailed:
                return @"The location manager did not enter deferred mode for an unknown reason.";
            case kCLErrorDeferredNotUpdatingLocation:
                return @"The location manager did not enter deferred mode because location updates were already disabled or paused.";
            case kCLErrorDeferredAccuracyTooLow:
                return @"Deferred mode is not supported for the requested accuracy.";
            case kCLErrorDeferredDistanceFiltered:
                return @"Deferred mode does not support distance filters.";
            case kCLErrorDeferredCanceled:
                return @"The request for deferred updates was canceled by your app or by the location manager.";
            case kCLErrorRangingUnavailable:
                return @"Ranging is disabled. This might happen if the device is in Airplane mode or if Bluetooth or location services are disabled.";
            case kCLErrorRangingFailure:
                return @"A general ranging error occurred.";
        }
    }

    return error.localizedDescription;
}

@end
