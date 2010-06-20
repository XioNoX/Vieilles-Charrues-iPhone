//
//  TableViewControllerConcert.m
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewControllerConcert.h"
#import "TableViewControllerArtistes.h"
#import "CellConcert.h"
#import "VCConcertParser.h"
#import "VCArtisteParser.h"
#import "constantes.h"
#import "VCUtils.h"
#import "TableViewDetailsConcert.h"
#import "VCFluxUpdater.h"
#import "VieillesCharruesAppAppDelegate.h"


@implementation TableViewControllerConcert

@synthesize popUpView;

- (IBAction) reloadTable
{
	[listeConcertParScene release];
	[listeGroupe release];
	listeConcertParScene = [[dataBase getConcertsDuJour:[NSNumber numberWithInt:(selector.selectedSegmentIndex +1)]] retain];
	listeGroupe = [[dataBase getListeArtistes] retain];
	[self.tableView reloadData];
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
	
	[self performSelectorInBackground:@selector(timerBeforeDeletingLaodingView) withObject:nil];
	
	[pool drain];
	
}

-(void)recupererProg;
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	VCFluxUpdater *updater = [[VCFluxUpdater alloc] init];
	
	[updater setDelegate:self];
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	boutonMiseAjour.enabled = YES;
	
	[updater miseAjourProg];
	
	[pool drain];
	
}


- (IBAction)mettreAJour:(id)sender 
{
	[self performSelectorInBackground:@selector(recupererProg) withObject:nil];
	boutonMiseAjour.enabled = NO;
	
	
	activityIndicator.frame = CGRectMake(07, 27, 30, 30);
	
	[self.view.window addSubview:activityIndicator];
	[activityIndicator startAnimating];
	
	
	[self reloadTable];
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

-(void) majEnded:(NSNumber *)test {
	
	[self popUpLoadingWithMessage:@"programmation à jour"];
	
	[self reloadTable];
	
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


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CellConcert *cell = (CellConcert*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[[CellConcert alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell = [[[NSBundle mainBundle] loadNibNamed:@"CellConcert" owner:self options:nil] objectAtIndex:0];
    }
	
	NSArray *arrayOfConcert = [NSArray arrayWithArray:[listeConcertParScene objectAtIndex:indexPath.section]];
    VCConcert *nouveauConcert = [arrayOfConcert objectAtIndex:indexPath.row];
	NSString *idArtiste = [NSString stringWithFormat:@"%i", [nouveauConcert.idArtiste intValue]];
	cell.tag = [nouveauConcert.idArtiste intValue];
	cell.groupe.text = [listeGroupe objectForKey:idArtiste];
	
	cell.heure.text = [VCUtils determinerHeureDebut:nouveauConcert.heureDebut heureFin:nouveauConcert.heureFin];
	
	cell.identifiant = [nouveauConcert.idConcert intValue];
	
	if(nouveauConcert.isFavori)
	{
		[cell.boutonFavori setSelected:YES];
	}
	
	int res = indexPath.row%2;
	
	if(res == 0)
	{
		UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
		bg.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.90 alpha:1]; // or any color
		cell.backgroundView = bg;
		[bg release];
		
	}
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	int idArtiste = [tableView cellForRowAtIndexPath:indexPath].tag;
	
	VCArtiste *artisteCourant = [dataBase getArtiste:idArtiste];
	
	TableViewDetailsConcert *anotherViewController = [[TableViewDetailsConcert alloc] init];
	
	[self.navigationController pushViewController:anotherViewController animated:YES];
	
	[anotherViewController  initWithArtiste:artisteCourant Concerts:[dataBase getConcertsDuGroupe:artisteCourant.ident]];
	
	[anotherViewController release];
}

- (IBAction) changerTri
{
	TableViewControllerArtistes *anotherViewController = [[TableViewControllerArtistes alloc] initWithNibName:@"TableViewControllerArtistes" bundle:nil];
	anotherViewController.listeGroupe = listeGroupe;
	anotherViewController.tableauDesScenes = tableauDesScenes;
	anotherViewController.listeConcertParScene = listeConcertParScene;
	anotherViewController.dataBase = dataBase;
	[self.navigationController pushViewController:anotherViewController animated:YES];
	
	[anotherViewController release];
}



- (void)dealloc {
	[dataBase release];
	[listeGroupe release];
	[listeConcertParScene release];
	[tableauDesScenes release];
	[listeConcertParScene release];
	[popUpView release];
    [super dealloc];
}


@end

