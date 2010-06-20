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

#import "TableViewControllerNews.h"
#import "CellNews.h"
#import "VCNews.h"
#import "VCNewsParser.h"
#import "NewsDetailsView.h"
#import "constantes.h"
#import "VieillesCharruesAppDelegate.h"


@implementation TableViewControllerNews

@synthesize maj;


-(void) reloadTable
{
	listeNews = [[dataBase getNews] retain];
	
	[self.tableView reloadData];
}



-(void) timerBeforeDeletingLaodingView
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[NSThread sleepForTimeInterval:2];
	
	[loadingMajView removeFromSuperview];
	
	[pool drain];
}

-(void) popUpLoadingWithMessage:(NSString*) msg
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	
	UIView *loadingView = [[[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil] objectAtIndex:0];
	loadingMajView = [loadingView retain];
	
	UILabel *labelPereDeSaints = ((UILabel*)[loadingView viewWithTag:1]);
	labelPereDeSaints.text = msg;
	VieillesCharruesAppDelegate *appDelegate = (VieillesCharruesAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	[[appDelegate window] addSubview:loadingView];
	
	[self performSelectorOnMainThread:@selector(timerBeforeDeletingLaodingView) withObject:nil waitUntilDone:NO];
	
	[pool drain];
	
}

-(void) recupererNews
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[maj miseAjourNews];
	
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
	self.maj = [[VCFluxUpdater alloc] init];
	[maj setDelegate:self];
	
	
	if(dataBase == nil) dataBase = [VCDataBaseController sharedInstance];
	self.tableView.rowHeight = 70;
	[self reloadTable];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark MAJ delegate

-(void)majEnded:(NSNumber *)test{
	[self popUpLoadingWithMessage:@"infos mises à jour"];
	
	[self reloadTable];	
	
}

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
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NewsDetailsView *anotherViewController = [[NewsDetailsView alloc] init];
	
	//récupération de la nouvelle dans la base de données
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	VCNews *nouvelleComplete = [dataBase getNewsWithId:cell.tag];
	
	[self.navigationController pushViewController:anotherViewController animated:YES];
	
	[anotherViewController initWithNouvelle:nouvelleComplete];
	[anotherViewController release];
}



- (void)dealloc {
	[maj release];
	[listeNews release];
	[dataBase release];
	[loadingMajView release];
    [super dealloc];
}


@end

