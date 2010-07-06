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

#import "NewsDetailsView.h"


@implementation NewsDetailsView

@synthesize datePub, description;


- (void) initWithNouvelle:(VCNews*) nouvelle
{
	self = [super initWithNibName: @"NewsDetailsView" bundle:nil];
	//mise en forme de la date pour l'affichage
	NSDateFormatter *formateurDeDate = [[NSDateFormatter alloc] init];
	[formateurDeDate setDateFormat:@"dd MMM yyyy HH:mm:ss"];
	[formateurDeDate setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	NSString *jour = [formateurDeDate stringFromDate:nouvelle.date];
	[formateurDeDate release];
	
	
	self.datePub.text = jour;
	[self.description loadHTMLString:nouvelle.description baseURL:nil ];
	
	
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


- (void)dealloc {
    [super dealloc];
}


@end
