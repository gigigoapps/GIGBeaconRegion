//
//  GIGErrorFactory.h
//  GIGBeaconRegion
//
//  Created by Alejandro Rupérez on 28/11/14.
//  Copyright (c) 2014 alexruperez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIGErrorFactory : NSObject

+ (NSError *)errorWithUnderlyingError:(NSError *)underlyingError;

@end
