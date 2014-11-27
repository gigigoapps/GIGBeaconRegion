//
//  GIGBeaconCell.m
//  GIGBeaconRegion
//
//  Created by Alejandro Rupérez on 27/11/14.
//  Copyright (c) 2014 Gigigo. All rights reserved.
//

#import "GIGBeaconCell.h"


@interface GIGBeaconCell ()

@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *proximityLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@end


@implementation GIGBeaconCell

- (void)setBeaconModel:(GIGBeaconModel *)beaconModel
{
    self.aliasLabel.text = beaconModel.alias;
    self.majorLabel.text = beaconModel.major;
    self.minorLabel.text = beaconModel.minor;
    self.proximityLabel.text = beaconModel.proximity;
    self.accuracyLabel.text = beaconModel.accuracy;
    self.rssiLabel.text = beaconModel.rssi;
    self.backgroundColor = beaconModel.color;
}

@end
