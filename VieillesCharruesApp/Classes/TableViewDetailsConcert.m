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

#import "TableViewDetailsConcert.h"
#import "CellDetailHeader.h"
#import "CellDetailsConcerts.h"
#import "CellDetailsDescription.h"
#import "VCUtils.h"

@implementation TableViewDetailsConcert


#pragma mark -
#pragma mark View lifecycle

-(void) initWithArtiste:(VCArtiste*)artisteCourant Concerts:(NSArray*)concertCourant
{
	artiste = [artisteCourant retain];
	listeConcert = [concertCourant retain];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
	self.tableView.rowHeight = 60;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger retour = 1;
	
	if(section == 1)
		retour = [listeConcert count];
	
	return retour;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGSize boundingSize;
	CGSize hauteurTexte;
	switch (indexPath.section) 
	{
		//cas de la cellule header
		case 0:
			return 100;
			break;
			
		//cas des cellules concerts
		case 1:
			return 60;
			break;
			
		//cas de la cellule de description de l'artiste
		case 2:
			boundingSize = CGSizeMake(292, 10000);
			hauteurTexte = [artiste.description sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17] constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];
			return hauteurTexte.height + 10;	
			break;
	}
	return 0;

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = nil;
	
	switch (indexPath.section) {
		case 0:
			cell = (CellDetailHeader*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[NSBundle mainBundle] loadNibNamed:@"CellDetailsHeader" owner:self options:nil] objectAtIndex:0];
			}
			[((CellDetailHeader*)cell) initWithArtiste:artiste];
			break;
		case 1:
			cell = (CellDetailsConcerts*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[NSBundle mainBundle] loadNibNamed:@"CellDetailsConcerts" owner:self options:nil] objectAtIndex:0];
			}
			[((CellDetailsConcerts*)cell) initWithConcert:[listeConcert objectAtIndex:indexPath.row]];
			break;
		default:
			//cell = (CellDetailsDescription*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[NSBundle mainBundle] loadNibNamed:@"CellDetailsDescription" owner:self options:nil] objectAtIndex:0];
			}
			[((CellDetailsDescription*)cell) initWithArtiste:artiste];
			break;
	}

    // Configure the cell...
    
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
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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

