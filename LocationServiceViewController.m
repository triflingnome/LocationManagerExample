//
//  ViewController.m
//  LocationManagerExample
//
//  Created by Michael Berg on 8/1/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "LocationServiceViewController.h"
#define LOCATION_ARRAY_MAX_SIZE 250

@interface LocationServiceViewController () {
    BOOL trackingOn;
}

@end

@implementation LocationServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize variables
    trackingOn = NO;
    self.locationArray = [[NSMutableArray alloc] init];
    
    // configure mapView
    self.mapView.showsUserLocation = YES;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 750, 750);
    [self.mapView setRegion:region animated:YES];
    
    // initialize and configure location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }// end if
    
}// end viewDidLoad:

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// starts and stops location manager from collecting location data and gives
// appropriate UI feedback
- (IBAction)startStopButtonAction:(id)sender {
    
    if (trackingOn == NO) {
        // change button appearance to stop
        [self changeButtonToStopAppearance:self.startStopButton];
        [self.locationManager startUpdatingLocation];
        trackingOn = YES;
    } else {// trackingOn == YES
        // change button appearance to start
        [self changeButtonToStartAppearace:self.startStopButton];
        [self.locationManager stopUpdatingLocation];
        trackingOn = NO;
    }// end if-else
    
}// end startStopButtonAction:

// changes button to reflect stop location tracking state
- (void)changeButtonToStopAppearance:(UIButton *)button {
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"Stop" forState:UIControlStateNormal];
    [button setTitle:@"Stop" forState:UIControlStateSelected];
}// end changeButtonToStopAppearance:

// changes button to reflect start location tracking state
- (void)changeButtonToStartAppearace:(UIButton *)button {
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"Start" forState:UIControlStateNormal];
    [button setTitle:@"Start" forState:UIControlStateSelected];
}// end changeButtonToStartAppearance:

// public method to add a CLLocation to the mutable array locationArray, with some memory management code
// to ensure it doesn't get too big
- (void)addLocationToLocationArray:(CLLocation *)location {
    NSLog(@"current size of locationArray: %lu", (unsigned long)[self.locationArray count]);
    
    if ([self.locationArray count] < LOCATION_ARRAY_MAX_SIZE) {
        [self.locationArray addObject:location];// adds the newest location to the end of the array
    } else {
        [self.locationArray removeObject:[self.locationArray firstObject]];// removes the first object (oldest stored location)
        [self.locationArray addObject:location];// adds the newest location to the end of the array
    }// end if-else
    
}// end addLocationToLocationArray:

- (void)updateRouteLineFromLocationArray {
    [self.mapView removeOverlay:self.routeLine];
    
    CLLocationCoordinate2D coordinates[[self.locationArray count]];
    int i = 0;
    for (CLLocation *currentLocation in self.locationArray) {
        coordinates[i] = currentLocation.coordinate;
        i++;
    }// end for
    
    MKPolyline *newRouteLine = [MKPolyline polylineWithCoordinates:coordinates count:[self.locationArray count]];
    self.routeLine = newRouteLine;
    [self.mapView addOverlay:self.routeLine];// when self.routeLine is added to self.mapView, mapView: rendererForOverlay delegate method is called
}// end updateRouteLineFromLocationArray

@end
