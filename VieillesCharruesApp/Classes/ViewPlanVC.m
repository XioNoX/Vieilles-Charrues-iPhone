//
//  ViewPlanVC.m
//
//  Created by ToM on 17/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewPlanVC.h"
#import "ViewLocation.h"
#import "ViewOuEstMaTente.h"

@implementation ViewPlanVC

-(void)viewDidLoad
{
	[super viewDidLoad];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pour bientôt" message:@"Le plan du site sera disponible juste avant le festival, n'oublie pas de télécharger la mise à jour avant d'arriver sur le site" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (IBAction)chargerPlan:(id)sender {
	ViewLocation *planDuSite = [[ViewLocation alloc] initWithNibName:@"ViewLocation" bundle:nil];
	[self.navigationController pushViewController:planDuSite animated:YES];
	[planDuSite release];
    
}

- (IBAction)ouEstMaTente:(id)sender {
	ViewOuEstMaTente *ouEstMaTente = [[ViewOuEstMaTente alloc] initWithNibName:@"ViewOuEstMaTente" bundle:nil];
	[self.navigationController pushViewController:ouEstMaTente animated:YES];
	[ouEstMaTente release];
}
@end
