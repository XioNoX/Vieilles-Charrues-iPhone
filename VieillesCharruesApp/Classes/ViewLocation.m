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

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isExtern:(BOOL)isExtern{
	
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	[self setEdgesForExternMap:isExtern];

	
	carte = [[UIImageView alloc] init];
	UIImage *imageCarte = nil;
	[carteScrollView setZoomScale:0];
	if(isExtern) {
		imageCarte = [UIImage imageNamed:@"carte_exterieure.jpg"];
		[carte setFrame:CGRectMake(0.0, 0.0, imageCarte.size.width/4, imageCarte.size.height/4)];
		[self setEdgesForExternMap:YES];
		
	}
	else {
		imageCarte = [UIImage imageNamed:@"carte_interieure.jpg"];
		[carte setFrame:CGRectMake(0.0, 0.0, imageCarte.size.width/2, imageCarte.size.height/2)];
		[self setEdgesForExternMap:NO];
	}
	[carte setImage:imageCarte];
	[carteScrollView addSubview:carte];
	[carteScrollView setContentSize:carte.frame.size];
	[imageCarte release];
	
	/*NSArray *choixSegmentedControll = [NSArray arrayWithObjects:@"Interieure", @"Exterieure", nil];
	
	carteSegmentedControl = [[UISegmentedControl alloc] initWithItems:choixSegmentedControll];
	[carteSegmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
	[carteSegmentedControl setSelectedSegmentIndex:0];
	[carteSegmentedControl addTarget:self action:@selector(changerCarte:) forControlEvents:UIControlEventValueChanged];
	[carteSegmentedControl setFrame:CGRectMake(0.0, .0, 200.0, 30.0)];
	
	self.navigationItem.titleView = carteSegmentedControl;
	[carteSegmentedControl release];*/
	
	return self;
	
}


-(void) changerCarte:(id)sender {
	
	carte = [[UIImageView alloc] init];
	UIImage *imageCarte = nil;
	[carteScrollView setZoomScale:0];
	if([(UISegmentedControl *)sender selectedSegmentIndex] == 1) {
		imageCarte = [UIImage imageNamed:@"carte_exterieure.jpg"];
		[carte setFrame:CGRectMake(0.0, 0.0, imageCarte.size.width/4, imageCarte.size.height/4)];
		[self setEdgesForExternMap:YES];
		
	}
	else {
		imageCarte = [UIImage imageNamed:@"carte_interieure.jpg"];
		[carte setFrame:CGRectMake(0.0, 0.0, imageCarte.size.width/2, imageCarte.size.height/2)];
		[self setEdgesForExternMap:NO];
	}
	[carte setImage:imageCarte];
	[carteScrollView addSubview:imageCarte];
	[carteScrollView setContentSize:carte.frame.size];
	[imageCarte release];
	[self recalculateLocation];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];    
	contenantPlan.delegate = self;
	
	locationController = [[VCCLLocationController alloc] init];
	locationController.appelant = self;
    //[locationController.locationManager startUpdatingLocation];
	
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

-(void) viewDidAppear:(BOOL)animated {
	//[self changerCarte:carteSegmentedControl];
	//[carteScrollView setFrame:CGRectMake(0.0, 0.0, 320.0, 411.0)];
	//[self.navigationController.navigationBar setAlpha:0.5];
}

-(float) determinerPositionX:(float) longitude
{
	float LONGUEUR = (pointHautGauche.x	- pointBasDroit.x);
	
	float distance = (pointHautGauche.x - longitude);
	NSLog(@"width : %f", carte.frame.size.width);
	return (distance/LONGUEUR) * carte.frame.size.width;
}

-(float) determinerPositionY:(float) latitude
{
	float HAUTEUR = (pointHautGauche.y	- pointBasDroit.y);
	
	float distance = (pointHautGauche.y - latitude);
	NSLog(@"height : %f", carte.frame.size.height);
	return (distance/HAUTEUR) * carte.frame.size.height;
}

-(void) updateLocation
{
	locationAcutelle.y = -3.5557938; //self.locationController.locAtuelle.coordinate.longitude; //48.2713400; 
	locationAcutelle.x = 48.2714828; //self.locationController.locAtuelle.coordinate.latitude; //;
	float positionX = [self determinerPositionX:locationAcutelle.x] - (pointLocalisation.frame.size.height/2);
	float positionY = [self determinerPositionY:locationAcutelle.y] - (pointLocalisation.frame.size.width/2);
	
	pointLocalisation.frame = CGRectMake(positionX, positionY, pointLocalisation.frame.size.width, pointLocalisation.frame.size.height);
	
}

-(void) setTenteLocation:(VCTente *)tenteParam
{
	tente = [tenteParam retain];
	nomTente.text = tente.nom;
	float positionX = [self determinerPositionX:tente.longitude] - (pointTente.frame.size.width/2);
	float positionY = [self determinerPositionY:tente.latitude]- (pointTente.frame.size.height/2);
	
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
	[timer release];
    [super dealloc];
}


@end
