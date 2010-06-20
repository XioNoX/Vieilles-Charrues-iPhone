/*
 * Copyright Thomas Belin 2010
 *
 * This file is part of Vieilles Charrues 2010.
 *
 * Vieilles Charrues 2010 is free software: you can redistribute it
 and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Vieilles Charrues 2010 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Vieilles Charrues 2010.  If not, see
 <http://www.gnu.org/licenses/>.
 */

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
