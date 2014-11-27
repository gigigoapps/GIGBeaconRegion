//
//  GIGStorage.m
//  GIGBeaconRegion
//
//  Created by Alejandro Rupérez on 27/11/14.
//  Copyright (c) 2014 Gigigo. All rights reserved.
//

#import "GIGStorage.h"


@interface GIGStorage ()

@property (strong, nonatomic) NSMutableDictionary *storage;

@end


@implementation GIGStorage

+ (instancetype)sharedStorage
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

#pragma mark - INIT

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        self.storage = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])]];
    }

    return self;
}

#pragma mark - PUBLIC

- (id)objectForKey:(NSString *)key
{
    return self.storage[key];
}

- (BOOL)setObject:(id)value forKey:(NSString *)key
{
    self.storage[key] = value;
    return [self synchronize];
}

- (BOOL)removeObjectForKey:(NSString *)key
{
    [self.storage removeObjectForKey:key];
    return [self synchronize];
}

#pragma mark - PRIVATE

- (BOOL)synchronize
{
    [[NSUserDefaults standardUserDefaults] setObject:self.storage forKey:NSStringFromClass([self class])];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
