//
//  ViewController.h
//  LocationManagerExample
//
//  Created by Michael Berg on 8/1/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LocationServiceViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) double distanceTraveledInMeters;
@property (nonatomic) CLLocation *lastLocation;
@property (nonatomic) NSMutableArray *locationArray;

@property IBOutlet UILabel *distanceTraveledLabel;
@property IBOutlet UIButton *startStopButton;
@property IBOutlet UILabel *timeElapsedLabel;
@property IBOutlet UIButton *clearRecordedStatsButton;
@property IBOutlet MKMapView *mapView;

- (void)updateDistanceTraveledLabel:(UILabel *)label;
- (void)addLocationToLocationArray:(CLLocation *)newLocation;
- (void)centerMapViewOnLocation:(CLLocation *)location;

@end

