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
/*
 #define LATITUDE_HAUT_GAUCHE 47.2850808
 #define LONGITUDE_HAUT_GAUCHE -1.5198469
 
 #define LATITUDE_BAS_DROITE 47.2791053
 #define LONGITUDE_BAS_DROITE -1.5130019*/

//*************************************** Vieilles Charrues
#define LATITUDE_HAUT_GAUCHE 48.26758
#define LONGITUDE_HAUT_GAUCHE -3.56220

#define LATITUDE_BAS_DROITE 48.27306
#define LONGITUDE_BAS_DROITE -3.55301


@implementation ViewLocation

@synthesize locationController;

-(void) setEdgesForExternMap:(BOOL) isExtern {
	
	if (!isExtern) {
		pointHautGauche.x = 48.26758;
		pointHautGauche.y = -3.56220;
		
		pointBasDroit.x = 48.27306;
		pointBasDroit.y = -3.55301;
	}
	else {
		pointHautGauche.x = 48.25630;
		pointHautGauche.y = -3.5925;
		
		pointBasDroit.x = 48.29372;
		pointBasDroit.y = -3.5350;
	}
	
	
}

-(void) recalculateLocation {
	
	float positionX = [self determinerPositionX:locationAcutelle.x] - (pointLocalisation.frame.size.height/2);
	float positionY = [self determinerPositionY:locationAcutelle.y] - (pointLocalisation.frame.size.width/2);
	
	if (![pointTente isHidden]) {
		float posTenteX = [self determinerPositionX:tente.longitude] - (pointTente.frame.size.width/2);
		float positionY = [self determinerPositionY:tente.latitude]- (pointTente.frame.size.height/2);
		pointTente.frame = CGRectMake(posTenteX, positionY, pointTente.frame.size.width, pointTente.frame.size.height);
	}
	
	pointLocalisation.frame = CGRectMake(positionX, positionY, pointLocalisation.frame.size.width, pointLocalisation.frame.size.height);
	
}

-(id) initMap:(BOOL)isExtern {
	
	self = [super init];
	
	[self setEdgesForExternMap:isExtern];
	
	locationController = [[VCCLLocationController alloc] init];
	
	[locationController setAppelant:self];
	
	carteScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 367.0)];
	[carteScrollView setDelegate:self];
	[carteScrollView setMultipleTouchEnabled:YES];
	
	plan = [[UIView alloc] init];
	
	
	UIImage *imageCarte = nil;
	[carteScrollView setZoomScale:0];
	
	if(isExtern) {
		imageCarte = [UIImage imageNamed:@"carte_exterieure.jpg"];
		carte = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, imageCarte.size.width/4, imageCarte.size.height/4)];
		[self setEdgesForExternMap:YES];
		
	}
	else {
		imageCarte = [UIImage imageNamed:@"carte_interieure.jpg"];
		carte = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, imageCarte.size.width/2.5, imageCarte.size.height/2.5)];
		[self setEdgesForExternMap:NO];
	}
	[carte setImage:imageCarte];
	
	pointLocalisation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"point_localisation.png"]];
	[pointLocalisation setHidden:YES];
	
	pointTente = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 20.0)];
	
	UIImageView *imageDrapeauTente = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bulle_tente.png"]];
	[imageDrapeauTente setFrame:CGRectMake(0.0, 0.0, imageDrapeauTente.frame.size.width , imageDrapeauTente.frame.size.height)];
	[pointTente setFrame:CGRectMake(0.0, 0.0,imageDrapeauTente.frame.size.width*2, imageDrapeauTente.frame.size.height*2)];
	[pointTente addSubview:imageDrapeauTente];
	
	nomTente = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 100.0, 25.0)];
	[nomTente setTextAlignment:UITextAlignmentCenter];
	[nomTente setBackgroundColor:[UIColor clearColor]];
	[nomTente setTextColor:[UIColor whiteColor]];
	[nomTente setFont:[UIFont fontWithName:@"Verdana" size:12.0]];
	[nomTente setText:@"test"];
	[pointTente addSubview:nomTente];
	[pointTente setHidden:YES];
	[imageDrapeauTente release];
	
	[plan setFrame:carte.frame];
	[plan addSubview:carte];
	[plan addSubview:pointTente];
	[plan addSubview:pointLocalisation];
	[carteScrollView setMaximumZoomScale:3];
	[carteScrollView setMinimumZoomScale:1];
	
	[carteScrollView addSubview:plan];
	[carteScrollView setContentSize:carte.frame.size];
	
	[carte release];
	
	[self setView:carteScrollView];
	[carteScrollView release];
	
	
	return self;
	
}


-(void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[locationController.locationManager stopUpdatingLocation];
	//[self.navigationController.navigationBar setAlpha:1];
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[locationController.locationManager startUpdatingLocation];
}


-(float) determinerPositionX:(float) longitude
{
	float LONGUEUR = (pointHautGauche.x	- pointBasDroit.x);
	
	float distance = (pointHautGauche.x - longitude);
	return (distance/LONGUEUR) * plan.frame.size.width;
}

-(float) determinerPositionY:(float) latitude
{
	float HAUTEUR = (pointHautGauche.y	- pointBasDroit.y);
	
	float distance = (pointHautGauche.y - latitude);
	return (distance/HAUTEUR) * plan.frame.size.height;
}

-(BOOL) isInBounds:(CGPoint) loc {
	
	BOOL test1 = loc.x >= pointHautGauche.x && loc.y >= pointHautGauche.y;
	BOOL test2 = loc.x <= pointBasDroit.x && loc.y <= pointBasDroit.y;
	return test1 && test2;
	
}

-(void) updateLocation
{
	locationAcutelle.y = self.locationController.locAtuelle.coordinate.longitude;  // -3.5624027;
	locationAcutelle.x = self.locationController.locAtuelle.coordinate.latitude; 	//48.2702259;
	
	if ([self isInBounds:locationAcutelle]) {
		[pointLocalisation setHidden:NO];
		float positionX = [self determinerPositionX:locationAcutelle.x] - (pointLocalisation.frame.size.height/2);
		float positionY = [self determinerPositionY:locationAcutelle.y] - (pointLocalisation.frame.size.width/2);
		
		pointLocalisation.frame = CGRectMake(positionX, positionY, pointLocalisation.frame.size.width, pointLocalisation.frame.size.height);
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Vous n'etes pas sur le site du festival" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
		[alert release];
	}

}

-(void) setTenteLocation:(VCTente *)tenteParam
{
	tente = [tenteParam retain];
	nomTente.text = tente.nom;
	[pointTente setHidden:NO];
	
	float positionX = [self determinerPositionX:tente.latitude] - (pointTente.frame.size.width/2);
	float positionY = [self determinerPositionY:tente.longitude] - (pointTente.frame.size.height/2);
	
	
	pointTente.frame = CGRectMake(positionX, positionY, pointTente.frame.size.width, pointTente.frame.size.height);
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView*) view
{ 
	return plan;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	pointLocalisation.transform = CGAffineTransformMakeScale(1/sqrt(scale), 1/sqrt(scale));
	pointTente.transform = CGAffineTransformMakeScale(1/sqrt(scale), 1/sqrt(scale));
	
	
	[carteScrollView setContentSize:plan.frame.size];
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
	[timer release];
	[locationController release];
	[carteScrollView release];
	[plan release];
	[pointLocalisation release];
	[carte release];
	[pointTente release];
	[nomTente release];
	[tente release];
    [super dealloc];
}


@end
