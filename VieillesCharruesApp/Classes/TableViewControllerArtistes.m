//
//  TableViewControllerArtistes.m
//  VieillesCharruesApp
//
//  Created by ToM on 29/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewControllerArtistes.h"
#import "TableViewDetailsConcert.h"
#import "CellArtiste.h"


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

#pragma mark alphabetic sort


- (void)sortCompagniesByFirstLetter {
	self.arrayOfFirstLetters = [[NSMutableArray alloc] initWithArray:[[dictonnaryOfCompagnies allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
}

- (void)populateCompagniesAlphabeticalDictionary {
	
	self.dictonnaryOfCompagnies = [[NSMutableDictionary alloc] init];
	
	for(NSString *firstLetter in [NSArray arrayWithObjects:UITableViewIndexSearch,@"0", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil]) {
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[dictonnaryOfCompagnies setObject:tempArray forKey:firstLetter];
		[tempArray release];
	}
	
	for(Evenement *evenement in arrayOfCompagnies) {
		
		NSString *firstLetter = [[[evenement label] substringToIndex:1] uppercaseString];
		NSMutableArray *existingArray;
		
		if([[NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil] containsObject:firstLetter]) {
			existingArray = [dictonnaryOfCompagnies valueForKey:@"0"];
			[existingArray addObject:evenement];
		}
		
		// Check if an array already exists for this first letter
		else if (existingArray = [dictonnaryOfCompagnies valueForKey:firstLetter]) {
			[existingArray addObject:evenement];
		}
	}
	
	// Sorting result
	[self sortCompagniesByFirstLetter];	
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
    
    CellArtiste *cell = (CellArtiste*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		//cell = [[[NSBundle mainBundle] loadNibNamed:@"CellConcert" owner:self options:nil] objectAtIndex:0];
		cell = [[[CellArtiste alloc] initWithStyle:UITableViewCellAccessoryDisclosureIndicator reuseIdentifier:CellIdentifier] autorelease];
    }
	
	

	
    //cell.groupe.text = [listeGroupe objectForKey:[NSString stringWithFormat:@"%i",[[arrayOfBandOrdered objectAtIndex:indexPath.row]intValue]]];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	cell.tag = [((NSNumber*)[arrayOfBandOrdered objectAtIndex:indexPath.row]) intValue];
	
	NSString *artiste = [listeGroupe objectForKey:[NSString stringWithFormat:@"%i",[[arrayOfBandOrdered objectAtIndex:indexPath.row]intValue]]];
	int res = indexPath.row%2;
	[cell loadWithArtiste:artiste parity:(res == 0)];

	
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

