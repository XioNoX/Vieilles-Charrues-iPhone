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

#import "TableVIewControllerPartenaires.h"
#import "CellPartenaires.h"


@implementation TableVIewControllerPartenaires


#pragma mark -
#pragma mark View lifecycle


-(NSArray*) initialiserPartenaires
{
	NSMutableArray *retour = [[NSMutableArray alloc] init];
	
	{
		NSMutableArray *part = [[NSMutableArray alloc] init];
		[part addObject:@"Pomona"];
		[part addObject:@"Brasseries Kronenbourg"];
		
		[retour addObject:part];
		[part release];
	}
	{
		NSMutableArray *part = [[NSMutableArray alloc] init];
		[part addObject:@"Queguiner Materiaux"];
		[part addObject:@"SFR"];
		[part addObject:@"Credit Agricole"];
		[part addObject:@"Breizh Cola"];
		
		[retour addObject:part];
		[part release];
	}
	{
		NSMutableArray *part = [[NSMutableArray alloc] init];
		[part addObject:@"Coreff"];
		[part addObject:@"Orangina Schweppes"];
		[part addObject:@"Mc Cain"];
		[part addObject:@"Toyota"];
		[part addObject:@"Le Cochon de Bretagne"];
		[part addObject:@"Durex"];
		[part addObject:@"LAG Guitars"];
		[part addObject:@"Espace Culturel E.Leclerc"];
		[part addObject:@"France Location"];
		
		[retour addObject:part];
		[part release];
	}
	{
		NSMutableArray *part = [[NSMutableArray alloc] init];
		[part addObject:@"MCM"];
		[part addObject:@"France Inter"];
		[part addObject:@"Le Mouv"];
		[part addObject:@"France Bleu"];
		[part addObject:@"Ouest France"];
		[part addObject:@"20 Minutes"];
		[part addObject:@"Le Télégramme"];
		[part addObject:@"Deezer"];
		[part addObject:@"Arte Live"];
		
		[retour addObject:part];
		[part release];
		
	}
	return [retour autorelease] ;
}

-(NSArray*) initialiserCategories
{
	NSMutableArray *retour = [[NSMutableArray alloc] init];
	
	[retour addObject:@"Parrains officiels"];
	[retour addObject:@"Partenaires officiels"];
	[retour addObject:@"Partenaires"];
	[retour addObject:@"Partenaires Médias"];
	
	return [retour autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.rowHeight = 70;
	tabPartenaires = [[self initialiserPartenaires] retain];
	categPartenaires = [[self initialiserCategories] retain];
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [categPartenaires count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSArray *tab = [tabPartenaires objectAtIndex:section];
    return [tab count];
}


-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	NSString *title = [categPartenaires objectAtIndex:section];
	
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
    
    CellPartenaires *cell = (CellPartenaires*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellPartenaires" owner:self options:nil] objectAtIndex:0];
    }
    
	[cell initWithNom:[[tabPartenaires objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
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
	[tabPartenaires release];
	[categPartenaires release];
    [super dealloc];
}


@end

