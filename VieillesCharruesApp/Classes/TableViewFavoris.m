//
//  TableViewFavoris.m
//  VieillesCharruesApp
//
//  Created by ToM on 07/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewFavoris.h"
#import "CellFavori.h"
#import "VCConcert.h"
#import "VCUtils.h"
#import "TableViewDetailsConcert.h"


@implementation TableViewFavoris


#pragma mark -
#pragma mark View lifecycle

-(void) reloadTable
{
	/*if(tableauConcertsFavoris != nil) 
		[tableauConcertsFavoris release];*/
	tableauConcertsFavoris = [[dataBase getConcertsFavoris] retain];
	dictionnaireDesArtistes = [[dataBase getListeArtistes] retain];
	dictionnaireDesScenes = [VCUtils getDictionnaireDesScenes];
	dictionnaireDesJours = [VCUtils getDictionnaireDesJours];
	[self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];	
	
	
	self.tableView.rowHeight = 60;
	dataBase = [VCDataBaseController sharedInstance];
}

-(void) viewWillAppear:(BOOL)animated
{
	[self reloadTable];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
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
    return [tableauConcertsFavoris count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[tableauConcertsFavoris objectAtIndex:section] count];
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	VCConcert *conc;
	BOOL isNotEmpty = [[tableauConcertsFavoris objectAtIndex:section] count] != 0;
	if(isNotEmpty)
		conc =  [[tableauConcertsFavoris objectAtIndex:section] objectAtIndex:0];
	else {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Aucun Favoris" message:@"Vous n'avez choisit aucun concert favori" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[message show];
		[message release];
	}

	NSString *retour = isNotEmpty ? [dictionnaireDesJours objectForKey:[NSString stringWithFormat:@"%i",[conc.idJour intValue]]] : @"";
	return retour;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CellFavori *cell = (CellFavori*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"CellFavori" owner:self options:nil] objectAtIndex:0];
    }
    
    VCConcert *concertCourant = [[tableauConcertsFavoris objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	
	NSString *bandName = [dictionnaireDesArtistes objectForKey:[NSString stringWithFormat:@"%i", [concertCourant.idArtiste intValue]]];
	NSString *nomScene = [dictionnaireDesScenes objectForKey:[NSString stringWithFormat:@"%i", [concertCourant.idScene intValue]]];
	NSString *heureConcert = [VCUtils determinerHeureDebut:concertCourant.heureDebut heureFin:concertCourant.heureFin];
	[cell initWithId:concertCourant.idArtiste Groupe:bandName scene:nomScene heure:heureConcert];
    
	
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
	int idArtiste = [tableView cellForRowAtIndexPath:indexPath].tag;
	
	VCArtiste *artisteCourant = [dataBase getArtiste:idArtiste];
	
	TableViewDetailsConcert *anotherViewController = [TableViewDetailsConcert alloc];
	
	[self.navigationController pushViewController:anotherViewController animated:YES];
	
	[anotherViewController  initWithArtiste:artisteCourant Concerts:[dataBase getConcertsDuGroupe:artisteCourant.ident]];
	
	[anotherViewController release];
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

