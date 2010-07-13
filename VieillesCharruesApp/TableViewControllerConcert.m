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

#import "TableViewControllerConcert.h"
#import "TableViewControllerArtistes.h"
#import "CellConcert.h"
#import "VCConcertParser.h"
#import "VCArtisteParser.h"
#import "constantes.h"
#import "VCUtils.h"
#import "TableViewDetailsConcert.h"
#import "VieillesCharruesAppAppDelegate.h"


@implementation TableViewControllerConcert

@synthesize popUpView;

- (void) sortConcertOfDay {
	

	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	for (NSArray *arrayOfConcert in listeConcertParScene) {
		arrayOfConcert = [arrayOfConcert sortedArrayUsingSelector:@selector(compareConcert:)];
		[tempArray addObject:arrayOfConcert];
	}

	listeConcertParScene = tempArray;
}


		 
- (IBAction) reloadTable
{
	[listeConcertParScene release];
	[listeGroupe release];
	listeConcertParScene = [[NSMutableArray arrayWithArray:[dataBase getConcertsDuJour:[NSNumber numberWithInt:(selector.selectedSegmentIndex +1)]]] retain];
	listeGroupe = [[dataBase  getListeArtistes] retain];
	[self.tableView reloadData];
	[self sortConcertOfDay];
}


-(void) timerBeforeDeletingLaodingView
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[NSThread sleepForTimeInterval:2];
	
	[popUpView removeFromSuperview];
	
	[pool drain];
}

-(void) popUpLoadingWithMessage:(NSString*) msg
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	
	self.popUpView = [[[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil] objectAtIndex:0];
	
	UILabel *labelPereDeSaints = ((UILabel*)[popUpView viewWithTag:1]);
	labelPereDeSaints.text = msg;
	
	VieillesCharruesAppAppDelegate *appDelegate = (VieillesCharruesAppAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	[[appDelegate window] addSubview:popUpView];
	
	[self performSelectorOnMainThread:@selector(timerBeforeDeletingLaodingView) withObject:nil waitUntilDone:NO];
	
	[pool drain];
	
}

-(void)recupererProg;
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	VCFluxUpdater *updater = [[VCFluxUpdater alloc] init];
	
	[updater setDelegate:self];
	
	[updater miseAjourProg];
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	boutonMiseAjour.enabled = YES;
	
	[pool drain];
	
}


- (IBAction)mettreAJour:(id)sender 
{
	[self performSelectorInBackground:@selector(recupererProg) withObject:nil];
	boutonMiseAjour.enabled = NO;
	
	activityIndicator.frame = CGRectMake(10.0, 10.0, 25, 25);
	
	[self.navigationController.navigationBar addSubview:activityIndicator];
	[activityIndicator startAnimating];
	
}


-(void) initConcertArray
{
	tableauDesScenes = [VCUtils getDictionnaireDesScenes];
}


- (void)viewDidLoad 
{
    [super viewDidLoad];

	[self initConcertArray];
	
	dataBase = [VCDataBaseController sharedInstance];

	
	self.tableView.rowHeight = 50;
	
	[self reloadTable];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

-(void) majEnded:(int)succes {
	if (succes == 0) {
		
		[self popUpLoadingWithMessage:@"programmation à jour"];
		
		[self reloadTable];
	}
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [listeConcertParScene count];
}

//titre de la section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	NSArray *test = [listeConcertParScene objectAtIndex:section];
	VCConcert *concert = [test objectAtIndex:0];
	return [tableauDesScenes objectForKey: [NSString stringWithFormat:@"%i", [concert.idScene intValue]]];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[listeConcertParScene objectAtIndex:section] count];
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	NSArray *test = [listeConcertParScene objectAtIndex:section];
	VCConcert *concert = [test objectAtIndex:0];
	NSString *title = [tableauDesScenes objectForKey: [NSString stringWithFormat:@"%i", [concert.idScene intValue]]];
	
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
	
	
	return sectionView;
	
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 25.0;
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CellConcert *cell = (CellConcert*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CellConcert alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		//cell = [[[NSBundle mainBundle] loadNibNamed:@"CellConcert" owner:self options:nil] objectAtIndex:0];
    }
	
	NSArray *arrayOfConcert = [NSArray arrayWithArray:[listeConcertParScene objectAtIndex:indexPath.section]];
    VCConcert *nouveauConcert = [arrayOfConcert objectAtIndex:indexPath.row];
	NSString *idArtiste = [listeGroupe objectForKey:[NSString stringWithFormat:@"%i", [nouveauConcert.idArtiste intValue]]];
	int res = indexPath.row%2;
	
	[cell loadWithConcert:nouveauConcert artiste:idArtiste parity:(res == 0)];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	int idArtiste = [tableView cellForRowAtIndexPath:indexPath].tag;
	
	VCArtiste *artisteCourant = [[VCDataBaseController sharedInstance] getArtiste:idArtiste];
	
	TableViewDetailsConcert *anotherViewController = [[TableViewDetailsConcert alloc] initWithNibName:@"TableViewDetailsConcert" bundle:nil];
	
	[self.navigationController pushViewController:anotherViewController animated:YES];
	
	[anotherViewController  initWithArtiste:artisteCourant Concerts:[dataBase getConcertsDuGroupe:artisteCourant.ident]];
	
	[anotherViewController release];
}

- (IBAction) changerTri {
	TableViewControllerArtistes *anotherViewController = [[TableViewControllerArtistes alloc] init];
	
	[self.navigationController pushViewController:anotherViewController animated:YES];
	
	[anotherViewController release];
}



- (void)dealloc {
	[listeGroupe release];
	[listeConcertParScene release];
	[tableauDesScenes release];
	[listeConcertParScene release];
	[popUpView release];
    [super dealloc];
}


@end

