//
//  ViewLocation.m
//  VieillesCharruesApp
//
//  Created by ToM on 31/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewLocation.h"

//#define LONGITUDE_MIN 48.267912
//#define LATITUDE_MIN -3.552689

//*************************************** Chez moi
/*
#define LATITUDE_HAUT_GAUCHE 47.22218
#define LONGITUDE_HAUT_GAUCHE -1.531692

#define LATITUDE_BAS_DROITE 47.219011
#define LONGITUDE_BAS_DROITE -1.526467*/

//*************************************** Polytech
#define LATITUDE_HAUT_GAUCHE 47.2850808
#define LONGITUDE_HAUT_GAUCHE -1.5198469

#define LATITUDE_BAS_DROITE 47.2791053
#define LONGITUDE_BAS_DROITE -1.5130019

float LARGEUR = (LATITUDE_HAUT_GAUCHE - LATITUDE_BAS_DROITE);
float LONGUEUR = (LONGITUDE_HAUT_GAUCHE - LONGITUDE_BAS_DROITE);

@implementation ViewLocation

@synthesize locationController;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];    
	contenantPlan.delegate = self;
	
	locationController = [[VCCLLocationController alloc] init];
	locationController.appelant = self;
    [locationController.locationManager startUpdatingLocation];

}

-(float) determinerPositionX:(float) longitude
{
	float distance = (LONGITUDE_HAUT_GAUCHE - longitude);
	return (distance/LONGUEUR) * 320;
}

-(float) determinerPositionY:(float) latitude
{
	float distance = (LATITUDE_HAUT_GAUCHE - latitude);
	return (distance/LARGEUR) * 320;
}

-(void) updateLocation
{
	float longitudePoint = self.locationController.locAtuelle.coordinate.longitude; //48.27263 - (LONG_SITE/4); 
	float latitudePoint = self.locationController.locAtuelle.coordinate.latitude; //-3.55268 + (LARG_SITE/2);
	float positionX = [self determinerPositionX:longitudePoint] - (pointLocalisation.frame.size.height/2);
	float positionY = [self determinerPositionY:latitudePoint] - (pointLocalisation.frame.size.width/2);
	pointLocalisation.frame = CGRectMake(positionX, positionY, pointLocalisation.frame.size.width, pointLocalisation.frame.size.height);
	
}

-(void) setTenteLocation:(VCTente *)tente
{
	nomTente.text = tente.nom;
	float positionX = [self determinerPositionX:tente.longitude] - (pointTente.frame.size.width/2);
	float positionY = [self determinerPositionY:tente.latitude]- (pointTente.frame.size.height/2);
	NSLog(@"%@ : %f, %f", tente.nom, positionX, positionY);

	pointTente.frame = CGRectMake(positionX, positionY, pointTente.frame.size.width, pointTente.frame.size.height);
	[pointTente setHidden:NO];
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView*) view
{ 
	return plan;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	pointLocalisation.transform = CGAffineTransformMakeScale(1/sqrt(scale), 1/sqrt(scale));
	pointTente.transform = CGAffineTransformMakeScale(1/sqrt(scale), 1/sqrt(scale));
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
