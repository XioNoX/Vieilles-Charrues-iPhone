//
//  ViewOuEstMaTente.m
//  VieillesCharruesApp
//
//  Created by ToM on 17/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewOuEstMaTente.h"
#import "CellTente.h"
#import "ViewLocation.h"

@implementation ViewOuEstMaTente


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	base = [VCDataBaseController sharedInstance];
	
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
	[self.navigationController.navigationBar setHidden:NO];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	[self.navigationController.navigationBar setHidden:YES];
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
	NSLog(@"longi : %f , lati : %f", longit, latit);
	if(longit != 0.0 || latit != 0.0)
	{			
		longi = longit;
		lati = latit;
		[indicateur stopAnimating];
		[cacheBouton removeFromSuperview];
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
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	 ViewLocation *detailViewController = [[ViewLocation alloc] initWithNibName:@"ViewLocation" bundle:nil];

	
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController setTenteLocation:[listeTentes objectAtIndex:indexPath.row]];
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

