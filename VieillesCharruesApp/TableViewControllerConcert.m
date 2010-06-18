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


@implementation TableViewControllerConcert


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
	
	UIView *vueMessage = [self.view.window viewWithTag:50000];
	
	[vueMessage removeFromSuperview];
	
	[pool drain];
}

-(void) popUpLoadingWithMessage:(NSString*) msg
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	
	UIView *loadingView = [[[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil] objectAtIndex:0];
	loadingView.tag = 50000;
	
	UILabel *labelPereDeSaints = ((UILabel*)[loadingView viewWithTag:1]);
	labelPereDeSaints.text = msg;
	[self.view.window addSubview:loadingView];
	
	[self performSelectorInBackground:@selector(timerBeforeDeletingLaodingView) withObject:nil];
	
	[pool drain];
	
}

-(void)recupererProg;
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSURL *urlProg = [NSURL URLWithString: SOURCE_XML_CONCERTS];
	NSURL *urlArtistes = [NSURL URLWithString:SOURCE_XML_ARTISTES];
	
	VCConcertParser* parserProg = [[VCConcertParser alloc] initWithContentsOfURL:urlProg];
	[parserProg setDelegate:parserProg];
	
	BOOL parsingSuccess = NO;
	
	parsingSuccess = [parserProg parse];
	if(!parsingSuccess){
		//NSLog(@"erreur de parsing du flux de la programmation");
	}
	
	VCArtisteParser* parserArt = [[VCArtisteParser alloc] initWithContentsOfURL:urlArtistes];
	[parserArt setDelegate:parserArt];
	
	parsingSuccess = parsingSuccess && [parserArt parse];
	
	if(!parsingSuccess){
		NSLog(@"erreur de parsing du flux des artistes");
	}
	
	if(parsingSuccess)
	{
		if(dataBase == nil) dataBase = [VCDataBaseController sharedInstance];
		[dataBase mettreAJourConcert:parserProg.listeConcert];
		[dataBase mettreAJourArtistes:parserArt.listeArtistes];
		[self popUpLoadingWithMessage:@"Programmation mise à jour"];
		[self reloadTable];
	}
	else 
	{
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"erreur" message:@"Une erreur s'est produite lors de la récupération de le programmation. Verifiez vos paramètres de connexion et recommencez" delegate:nil cancelButtonTitle:@"fermer" otherButtonTitles:nil];
		
		[message show];
		[message release];
	}
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	boutonMiseAjour.enabled = YES;
	
	[parserProg release];
	
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


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
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


- (void)dealloc {
    [super dealloc];
}


@end

