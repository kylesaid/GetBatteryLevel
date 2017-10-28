//
//  Clipboard.m
//  CutBorad
//
//  Created by ThreeCM on 18/08/2017.
//  Copyright © 2017 threecm. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Clipboard.h"

@interface Clipboard()

extern "C"
{
    float getiOSBatteryLevel();
}

@end


@implementation Clipboard


@end

extern "C" {
    float getiOSBatteryLevel(){
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        return [[UIDevice currentDevice] batteryLevel];
    }
}
