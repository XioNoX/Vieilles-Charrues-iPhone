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

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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

