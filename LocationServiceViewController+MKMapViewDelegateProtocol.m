//
//  LocationServiceViewController+MKMapViewDelegateProtocol.m
//  LocationManagerExample
//
//  Created by Michael Berg on 8/3/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "LocationServiceViewController+MKMapViewDelegateProtocol.h"

@implementation LocationServiceViewController (MKMapViewDelegateProtocol)

// updates the center coordinate to the map follows the user's movements
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}

@end
