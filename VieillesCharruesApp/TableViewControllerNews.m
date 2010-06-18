//
//  TableViewControllerNews.m
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewControllerNews.h"
#import "CellNews.h"
#import "VCNews.h"
#import "VCNewsParser.h"
#import "NewsDetailsView.h"
#import "constantes.h"

@implementation TableViewControllerNews

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

-(void) reloadTable
{
	listeNews = [[dataBase getNews] retain];
	
	[self.tableView reloadData];
}



-(void) timerBeforeDeletingLaodingView
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	
	[NSThread sleepForTimeInterval:2];
	
	UIView *vueMessage = [self.view.window viewWithTag:1024];
	
	[vueMessage removeFromSuperview];
	
	[pool drain];
}

-(void) popUpLoadingWithMessage:(NSString*) msg
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	
	UIView *loadingView = [[[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil] objectAtIndex:0];
	loadingView.tag = 1024;
	
	UILabel *labelPereDeSaints = ((UILabel*)[loadingView viewWithTag:1]);
	labelPereDeSaints.text = msg;
	[self.view.window addSubview:loadingView];
	
	[self performSelectorInBackground:@selector(timerBeforeDeletingLaodingView) withObject:nil];
	
	[pool drain];
	
}

-(void) recupererNews
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	BOOL parsingSuccess = NO;
	
	NSURL *url = [NSURL URLWithString: TWITSOURCE];
	
	VCNewsParser* parser = [[VCNewsParser alloc] initWithContentsOfURL:url andType:@"Twitter"];
	[parser setDelegate:parser];
	parsingSuccess = [parser parse];
	
	
	url = [NSURL URLWithString:FBSOURCE];
	[parser initWithContentsOfURL:url andType:@"Facebook"];
	
	parsingSuccess = parsingSuccess && [parser parse];
	
	url = [NSURL URLWithString: VCSOURCE];
	[parser initWithContentsOfURL:url andType:@"VieillesCharrues"];
	
	parsingSuccess = parsingSuccess && [parser parse];
	
	if(dataBase == nil) dataBase = [VCDataBaseController sharedInstance];
	
	if(parsingSuccess)
	{
		[self popUpLoadingWithMessage:@"Actualités mises à jour"];
		[self reloadTable];
		[dataBase mettreAJourNews:parser.listeNews];
	}
	else 
	{
		UIAlertView *errorMessage = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Une erreur s'est produite lors de la récupération des actualités. Veuillez véfifier vos paramètres de connexion et reessayer" delegate:nil cancelButtonTitle:@"Fermer" otherButtonTitles:nil];
		[errorMessage show];
		[errorMessage release];
	}

	
	[parser release];
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	boutonMiseAjour.enabled = YES;
	
	[pool drain];
}



- (IBAction)mettreAJour:(id)sender
{
	
	[self performSelectorInBackground:@selector(recupererNews) withObject:nil];
	boutonMiseAjour.enabled = NO;
	
	
	activityIndicator.frame = CGRectMake(07, 27, 30, 30);
	[self.view.window addSubview:activityIndicator];
	[activityIndicator startAnimating];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	if(dataBase == nil) dataBase = [VCDataBaseController sharedInstance];
	self.tableView.rowHeight = 70;
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
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listeNews count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CellNews *cell = (CellNews*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[[CellNews alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell = [[[NSBundle mainBundle] loadNibNamed:@"CellNews" owner:self options:nil] objectAtIndex:0];
    }
    
	VCNews *nouvelle = [listeNews objectAtIndex:indexPath.row];
	
	NSDateFormatter *formateurDeDate = [[NSDateFormatter alloc] init];
	[formateurDeDate setDateFormat:@"dd MMM yyyy HH:mm:ss"];
	[formateurDeDate setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	NSString *jour = [formateurDeDate stringFromDate:nouvelle.date];
	[formateurDeDate release];
	
	UIImage *logo = nil;
	if([nouvelle.source isEqualToString:@"Twitter"])
		logo = [UIImage imageNamed:@"Twitter.png"];
	else if([nouvelle.source isEqualToString:@"Facebook"])
		logo = [UIImage imageNamed:@"Facebook.png"];
	else if([nouvelle.source isEqualToString:@"VieillesCharrues"])
		logo = [UIImage imageNamed:@"VieillesCharrues.png"];
	
	cell.tag = [nouvelle.idNews intValue];
	if([nouvelle.titre length] > 5)
		cell.titre.text = nouvelle.titre;
	else {
		cell.titre.text = nouvelle.description;
	}

	cell.datePub.text = jour;
	[cell.logo setImage:logo];
	
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
	
	NewsDetailsView *anotherViewController = [[NewsDetailsView alloc] init];
	
	//récupération de la nouvelle dans la base de données
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	VCNews *nouvelleComplete = [dataBase getNewsWithId:cell.tag];
	
	[self.navigationController pushViewController:anotherViewController animated:YES];
	
	[anotherViewController initWithNouvelle:nouvelleComplete];
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

