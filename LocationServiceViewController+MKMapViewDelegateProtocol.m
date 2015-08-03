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

// this method is automatically called by the delegate when a polyline is added to the map view
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc]initWithPolyline:route];
        routeRenderer.strokeColor = [UIColor yellowColor];
        routeRenderer.lineWidth = 5;
        return routeRenderer;
    } else return nil;
    
    //return self.routeLineRenderer;
}

@end
