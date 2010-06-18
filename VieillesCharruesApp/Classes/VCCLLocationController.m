//
//  VCCLLocationController.m
//  VieillesCharruesApp
//
//  Created by ToM on 01/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCCLLocationController.h"
#import "ViewLocation.h"


@implementation VCCLLocationController

@synthesize locationManager, locAtuelle, appelant;

- (id) init {
    self = [super init];
    if (self != nil) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self; // send loc updates to myself
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	self.locAtuelle = newLocation;
	[((ViewLocation *)self.appelant) updateLocation];
	[self.locationManager stopUpdatingHeading];
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

- (void)dealloc {
    [self.locationManager release];
    [super dealloc];
}

@end
