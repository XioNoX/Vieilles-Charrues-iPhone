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
	
	
	pointLocalisation.frame = CGRectMake(positionX, positionY, pointLocalisation.frame.size.width, pointLocalisation.frame.size.height);
	
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	[self setEdgesForExternMap:NO];
	[self.view setFrame:CGRectMake(0.0, 0.0, 320.0, 411.0)];
	
	NSArray *choixSegmentedControll = [NSArray arrayWithObjects:@"Interieure", @"Exterieure", nil];
	
	UISegmentedControl *carteSegmentedControl = [[UISegmentedControl alloc] initWithItems:choixSegmentedControll];
	[carteSegmentedControl setAlpha:0.8];
	[carteSegmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
	[carteSegmentedControl setSelectedSegmentIndex:0];
	[carteSegmentedControl addTarget:self action:@selector(changerCarte:) forControlEvents:UIControlEventValueChanged];
	[carteSegmentedControl setFrame:CGRectMake(0.0, .0, 200.0, 30.0)];
	
	self.navigationItem.titleView = carteSegmentedControl;
	//[[self view] addSubview:carteSegmentedControl];
	
	[carteSegmentedControl release];
	
	return self;
	
}


-(void) changerCarte:(id)sender {
	
	if([(UISegmentedControl *)sender selectedSegmentIndex] == 1) {
		[carte setImage:[UIImage imageNamed:@"carte_exterieure.png"]];
		[self setEdgesForExternMap:YES];
		[self recalculateLocation];
	}
	else {
		[carte setImage:[UIImage imageNamed:@"carte_interieure.jpg"]];
		[self setEdgesForExternMap:NO];
		[self recalculateLocation];
	}

	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];    
	contenantPlan.delegate = self;
	
	locationController = [[VCCLLocationController alloc] init];
	locationController.appelant = self;
    [locationController.locationManager startUpdatingLocation];
	[self.navigationController.navigationBar setAlpha:0.1];
	
}

-(void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[locationController.locationManager stopUpdatingLocation];
	[self.navigationController.navigationBar setAlpha:1];
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[locationController.locationManager startUpdatingLocation];
}


-(float) determinerPositionX:(float) longitude
{
	float LONGUEUR = (pointHautGauche.x	- pointBasDroit.x);
	
	float distance = (pointHautGauche.x - longitude);
	return (distance/LONGUEUR) * 320;
}

-(float) determinerPositionY:(float) latitude
{
	float HAUTEUR = (pointHautGauche.y	- pointBasDroit.y);
	
	float distance = (pointHautGauche.y - latitude);
	return (distance/HAUTEUR) * 411;
}

-(void) updateLocation
{
	locationAcutelle.y = -3.5558796; //self.locationController.locAtuelle.coordinate.longitude; //48.2713400; 
	locationAcutelle.x = 48.2664552; //self.locationController.locAtuelle.coordinate.latitude; //;
	float positionX = [self determinerPositionX:locationAcutelle.x] - (pointLocalisation.frame.size.height/2);
	float positionY = [self determinerPositionY:locationAcutelle.y] - (pointLocalisation.frame.size.width/2);
	
	
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
	[timer release];
    [super dealloc];
}


@end
