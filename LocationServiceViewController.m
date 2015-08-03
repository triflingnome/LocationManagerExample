//
//  ViewController.m
//  LocationManagerExample
//
//  Created by Michael Berg on 8/1/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "LocationServiceViewController.h"

@interface LocationServiceViewController () {
    BOOL trackingOn;
    int secondsElapsed;
    int minutesElapsed;
}

@end

@implementation LocationServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize variables
    trackingOn = NO;
    secondsElapsed = 0;
    minutesElapsed = 0;
    self.distanceTraveledInMeters = 0.0;
    self.locationArray = [[NSMutableArray alloc] init];
    
    // initialize and configure location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }// end if
    
    // create timer to method to execute every second to show time elapsed
    [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                                selector: @selector(updateElapsedTimeLabel:)
                                                userInfo: nil
                                                repeats: YES];
    
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

- (IBAction)clearRecordedStatsButtonAction:(id)sender {
    secondsElapsed = minutesElapsed = 0;
    self.timeElapsedLabel.text = @"0 m 0 s";
    
    self.lastLocation = nil;
    self.distanceTraveledInMeters = 0.0;
    self.distanceTraveledLabel.text = @"0.00 mi";
}

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

- (void)updateDistanceTraveledLabel:(UILabel *)label {
    double distanceTraveledInMiles = self.distanceTraveledInMeters * 0.00062137f;
    
    NSString *distanceString = [NSString stringWithFormat:@"%.2f mi", distanceTraveledInMiles];
    label.text = distanceString;
}

- (void)updateElapsedTimeLabel:(id)sender {
    
    if (trackingOn == YES) {
        secondsElapsed++;
        
        if (secondsElapsed % 60 == 0 && secondsElapsed != 0) {
            secondsElapsed = 0;
            minutesElapsed++;
        }// end if
    
        self.timeElapsedLabel.text = [NSString stringWithFormat:@"%i m %i s", minutesElapsed, secondsElapsed];
    }// end if
    
}// end updateElapsedTimeLabel:

// public method to add a CLLocation to the mutable array locationArray, with some memory management code
// to ensure it doesn't get too big
- (void)addLocationToLocationArray:(CLLocation *)newLocation {
    
}

@end
