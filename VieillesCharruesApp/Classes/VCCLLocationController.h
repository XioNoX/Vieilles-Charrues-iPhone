//
//  VCCLLocationController.h
//  VieillesCharruesApp
//
//  Created by ToM on 01/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface VCCLLocationController : NSObject <CLLocationManagerDelegate> 
{
	CLLocationManager *locationManager;
	CLLocation *locAtuelle;
	id appelant;
}
@property (nonatomic, retain) id appelant;
@property (nonatomic, retain) CLLocationManager *locationManager;  
@property (nonatomic, retain) CLLocation *locAtuelle;  
	
- (void)locationManager:(CLLocationManager *)manager
didUpdateToLocation:(CLLocation *)newLocation
fromLocation:(CLLocation *)oldLocation;
	
- (void)locationManager:(CLLocationManager *)manager
didFailWithError:(NSError *)error;
	
@end
