//
//  LocationServiceViewController+CLLocationManagerDelegateProtocol.m
//  LocationManagerExample
//
//  Created by Michael Berg on 8/1/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "LocationServiceViewController+CLLocationManagerDelegateProtocol.h"

@implementation LocationServiceViewController (CLLocationManagerDelegateProtocol)

// this delegate method is called when the phone's location is updated.
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self addLocationToLocationArray:[locations lastObject]];
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        NSLog(@"Location updated in foreground");
        // mapView.showAnnotations(locations, animated: true)
        [self updateRouteLineFromLocationArray];// draw route on map only if app is in foreground
    } else {
        NSLog(@"Location updated in background");
    }// end if-else
    

    
    // code to calculate distance traveled in foreground
    /*if (self.lastLocation == nil) {
        self.lastLocation = [locations lastObject];
    }
    
    self.distanceTraveledInMeters += [self.lastLocation distanceFromLocation:[locations lastObject]];
    
    self.lastLocation = [locations lastObject];
    [self updateDistanceTraveledLabel:self.distanceTraveledLabel];*/
}

@end
