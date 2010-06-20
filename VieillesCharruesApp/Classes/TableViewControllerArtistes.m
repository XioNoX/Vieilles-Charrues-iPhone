//
//  TableViewControllerArtistes.m
//  VieillesCharruesApp
//
//  Created by ToM on 29/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewControllerArtistes.h"
#import "CellConcert.h"
#import "TableViewDetailsConcert.h"


@implementation TableViewControllerArtistes

@synthesize dataBase, listeConcertParScene, listeGroupe, tableauDesScenes;



- (void)viewDidLoad {
    [super viewDidLoad];
	arrayOfBandOrdered = [[dataBase getListeArtistesOrdered] retain];	
	self.tableView.rowHeight = 50;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayOfBandOrdered count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CellConcert *cell = (CellConcert*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"CellConcert" owner:self options:nil] objectAtIndex:0];
    }
    cell.groupe.text = [listeGroupe objectForKey:[NSString stringWithFormat:@"%i",[[arrayOfBandOrdered objectAtIndex:indexPath.row]intValue]]];
	cell.tag = [((NSNumber*)[arrayOfBandOrdered objectAtIndex:indexPath.row]) intValue];
	
	
	int res = indexPath.row%2;
	
	[cell.boutonFavori setHidden:YES];
	cell.groupe.frame = CGRectMake(cell.groupe.frame.origin.x -30, cell.groupe.frame.origin.y, cell.groupe.frame.size.width, cell.groupe.frame.size.height);
	if(res == 0)
	{
		UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
		bg.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.90 alpha:1]; 
		cell.backgroundView = bg;
		[bg release];
		
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	int idArtiste = [tableView cellForRowAtIndexPath:indexPath].tag;
	
	VCArtiste *artisteCourant = [dataBase getArtiste:idArtiste];
	
	TableViewDetailsConcert *anotherViewController = [TableViewDetailsConcert alloc];
	
	[self.navigationController pushViewController:anotherViewController animated:YES];
	
	[anotherViewController  initWithArtiste:artisteCourant Concerts:[dataBase getConcertsDuGroupe:artisteCourant.ident]];
	
	[anotherViewController release];
}



- (void)dealloc {
	[dataBase release];
	[listeGroupe release];
	[arrayOfBandOrdered release];
	[tableauDesScenes release];
	[listeConcertParScene release];
    [super dealloc];
}
@end

