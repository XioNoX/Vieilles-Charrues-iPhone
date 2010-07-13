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
		[self setView:[[[UIView alloc] initWithFrame:CGRectMake(.0, .0, 320.0, 367.0)] autorelease]];
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
	[tempArrayOfBand release];
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



-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	NSString *title = [arrayOfLetters objectAtIndex:section];
	
	UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 25.0)];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"section_background.png"]];
	[sectionView addSubview:imageView];
	[imageView release];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 200.0, 25.0)];
	[titleLabel setBackgroundColor:[UIColor clearColor]];
	[titleLabel setTextColor:[UIColor whiteColor]];
	[titleLabel setText:title];
	[titleLabel setShadowColor:[UIColor blackColor]];
	[titleLabel setShadowOffset:CGSizeMake(0.5, 0.5)];
	[titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
	[sectionView addSubview:titleLabel];
	[titleLabel release];
	
	
	return [sectionView autorelease];
	
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 25.0;
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CellArtiste *cell = (CellArtiste*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[CellArtiste alloc] initWithStyle:UITableViewCellAccessoryDisclosureIndicator reuseIdentifier:CellIdentifier] autorelease];
    }
	
	
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	VCArtiste *artiste = [[BandSorted objectForKey:[arrayOfLetters objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
	cell.tag = [[artiste ident] intValue];
	int res = indexPath.row%2;
	[cell loadWithArtiste:[artiste nom] parity:(res != 0)];
	
	
    return cell;
}


-(NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView {
	NSMutableArray	*tableauLettres = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
	
	for (NSString *lettre in arrayOfLetters) {
		[tableauLettres addObject:lettre];
	}
	
	return tableauLettres;
}

-(NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	
	if (index == 0) {
		return 0;
	}
	else {
		return index - 1;
	}

	
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
	[arrayOfBandOrdered release];
	[BandSorted release];
	[arrayOfLetters release];
    [super dealloc];
}
@end

