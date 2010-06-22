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

#import "ViewOuEstMaTente.h"
#import "CellTente.h"
#import "ViewLocation.h"

@implementation ViewOuEstMaTente


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	base = [VCDataBaseController sharedInstance];
	
	pointInternHautGauche.x = 48.26758;
	pointInternHautGauche.y = -3.56220;
	
	pointInternBasDroit.x = 48.27306;
	pointInternBasDroit.y = -3.55301;
	
	pointExternHautGauche.x = 48.25630;
	pointExternHautGauche.y = -3.5925;
	
	pointExternBasDroit.x = 48.29372;
	pointExternBasDroit.y = -3.5350;
	
	locationController = [[VCCLLocationController alloc] init];
	locationController.appelant = self;
	lati = 0.0;
	longi = 0.0;
	listeTentes = [[base getTentes] retain];
	
	self.navigationItem.rightBarButtonItem = boutonPlus;
	
	self.tableView.rowHeight = 80;
}



- (void)viewWillAppear:(BOOL)animated {
	[super viewWillDisappear:animated];
	//[self.navigationController.navigationBar setHidden:NO];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	//[self.navigationController.navigationBar setHidden:YES];
}

-(void)reloadDataFromDataBase
{
	listeTentes = [[base getTentes] retain];
	[self.tableView reloadData];
	
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag == 0)
	{
		
		if(buttonIndex == 1)
		{
			UITextField *tf = (UITextField*)[alertView viewWithTag:12];
			nomTente = [tf.text retain];
			if (longi != 0.0 && lati !=0.0) {
				nouvelleTente = [[VCTente alloc] initWithNom:nomTente longitude:longi latitude:lati];
				[base ajouterTente:nouvelleTente];
				[locationController.locationManager stopUpdatingLocation];
				[self reloadDataFromDataBase];
			}
		}
		else {
			[locationController.locationManager stopUpdatingLocation];
		}

		[textFieldNomTente removeFromSuperview];
			
		}
	else {
		if(buttonIndex == 1)
		{
			[base supprimerTente:alertView.tag];
			[self reloadDataFromDataBase];
		}
	}

}

-(void)updateLocation
{
	CGFloat longit = locationController.locationManager.location.coordinate.longitude;
	CGFloat latit = locationController.locationManager.location.coordinate.latitude;
	
	
	if(longit != 0.0 || latit != 0.0)
	{			
		longi = longit;
		lati = latit;
		[indicateur stopAnimating];
		[cacheBouton removeFromSuperview];
		[locationController.locationManager stopUpdatingLocation];
	}
}

-(IBAction) ajouterTente
{
	UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Nom de la nouvelle tente" message:@"vide" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Valider",nil];
	
	alert.tag = 0;
    [locationController.locationManager startUpdatingLocation];
	
	textFieldNomTente.frame = CGRectMake(30, 40, 225, 30);
	cacheBouton.frame = CGRectMake(-117, -33, 126, 40);
	[indicateur startAnimating];
	
	[alert addSubview:textFieldNomTente];
	[alert addSubview:cacheBouton];
	
	
	[alert setTransform:CGAffineTransformMakeTranslation(0, 50)];
	[alert show];
	[alert release];
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [listeTentes count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CellTente *cell = (CellTente*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellTente" owner:self options:nil] objectAtIndex:0];
	}
	VCTente *tente = [listeTentes objectAtIndex:indexPath.row];
	
	[cell initWithTente:tente];
    
	
	int res = indexPath.row%2;
	
	if(res == 0)
	{
		UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
		bg.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.90 alpha:1]; 
		cell.backgroundView = bg;
		[bg release];
		
	}
    
    return cell;
}

-(BOOL) determinerZone:(VCTente *) tente {
	
	return tente.longitude >= pointInternHautGauche.y && tente.latitude >= pointInternHautGauche.x && tente.latitude <= pointInternBasDroit.x && tente.longitude <= pointInternBasDroit.y;
	
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	VCTente *tente = [listeTentes objectAtIndex:indexPath.row];
	
	BOOL isIntern = [self determinerZone:tente];
	ViewLocation *detailViewController = [[ViewLocation alloc] initMap:!isIntern];

	
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController setTenteLocation:tente];
	 [detailViewController release];
	 
}

-(IBAction) supprimerTente:(UIButton*)sender
{
	UIAlertView *alertSuppression = [[UIAlertView alloc] initWithTitle:@"Supprimer tente" message:@"Supprimer la tente ?" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Valider",nil];
	alertSuppression.tag = sender.tag;
	[alertSuppression show];
	[alertSuppression release];
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

