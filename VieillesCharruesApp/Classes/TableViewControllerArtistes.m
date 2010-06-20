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

#pragma mark alphabetic sort

-(id) init {
	if(self = [super init]) {
		[self setView:[[UIView alloc] initWithFrame:CGRectMake(.0, .0, 320.0, 367.0)]];
		[self.view setBackgroundColor:[UIColor whiteColor]];
		
		artistesTableView = [[[UITableView alloc] initWithFrame:CGRectMake(.0, .0, 320.0, 367.0)] retain];
		[artistesTableView setDelegate:self];
		[artistesTableView setDataSource:self];
		[[self view]addSubview:artistesTableView];
		[artistesTableView release];
		
		
		dataBase = [VCDataBaseController sharedInstance];
		arrayOfBandOrdered = [[dataBase getListeArtistesOrdered] retain];	
		arrayOfLetters = [[NSMutableArray alloc] init];
		
		[self createDictionary];
				
		artistesTableView.rowHeight = 50;
		
	}
	return self;
}

- (void)createDictionary {
	
	BandSorted = [[NSMutableDictionary alloc] init];
	
	NSString *lettreCourante = nil;
	NSString *lettrePrecedente = nil;
	
	NSMutableArray *tempArrayOfBand = [[NSMutableArray alloc] init];
	for (VCArtiste *art in arrayOfBandOrdered) {
		NSString *nom = [art nom];
		lettreCourante = [nom substringToIndex:1];
		if (lettrePrecedente != nil) {
			
			if (![lettreCourante isEqualToString:lettrePrecedente]) {
				[arrayOfLetters addObject:lettrePrecedente];
				[BandSorted setObject:tempArrayOfBand forKey:lettrePrecedente];
				[tempArrayOfBand release];
				tempArrayOfBand = [[NSMutableArray alloc] init];
			}
		}
		
		[tempArrayOfBand addObject:art];
		lettrePrecedente = lettreCourante;
	}
	[arrayOfLetters addObject:lettreCourante];
	[BandSorted setObject:tempArrayOfBand forKey:lettreCourante];
	[lettreCourante release];
	[lettrePrecedente release];
	
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}





#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [BandSorted count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[BandSorted objectForKey:[arrayOfLetters objectAtIndex:section]] count];
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [arrayOfLetters objectAtIndex:section];
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
	VCArtiste *artiste = [[BandSorted objectForKey:[arrayOfLetters objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
	cell.tag = [[artiste ident] intValue];
	int res = indexPath.row%2;
	[cell loadWithArtiste:[artiste nom] parity:(res != 0)];
	
	
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
	[artistesTableView release];
	[dataBase release];
	[arrayOfBandOrdered release];
	[BandSorted release];
	[arrayOfLetters release];
    [super dealloc];
}
@end

