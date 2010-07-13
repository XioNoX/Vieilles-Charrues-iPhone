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
#import "BrowserViewController.h"


@implementation NewsDetailsView

@synthesize datePub, description;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
		UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news_fond.png"]];
		[[self view] insertSubview:backgroundImage atIndex:0];
		[backgroundImage release];
		
		
		[description setOpaque:NO];
		[description setBackgroundColor:[UIColor clearColor]];
		
		
		
	}
	
	return self;
}

- (void) initWithNouvelle:(VCNews*) nouvelle
{
	self = [super initWithNibName: @"NewsDetailsView" bundle:nil];
	//mise en forme de la date pour l'affichage
	NSDateFormatter *formateurDeDate = [[NSDateFormatter alloc] init];
	[formateurDeDate setDateFormat:@"dd MMM yyyy HH:mm:ss"];
	NSString *jour = [formateurDeDate stringFromDate:nouvelle.date];
	[formateurDeDate release];
	
	
	self.datePub.text = jour;
	
	NSMutableString *htmlStr = [[NSMutableString alloc] init];
	[htmlStr appendString:@"<html><head><style> body {font-family:Helvetica; font-size:large;} </style></head><body>"];
	[htmlStr appendString:nouvelle.description];
	[htmlStr appendString:@"</html>"];
	[self.description loadHTMLString:htmlStr baseURL:nil ];
	[htmlStr release];
	[description setDelegate:self];
	
	
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	
	NSString *strTaille = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
	
	CGRect frame = description.frame;
	frame.size.height = [strTaille floatValue];
	
	description.frame = frame;
	
	[((UIScrollView *) self.view) setContentSize:CGSizeMake(320.0,  description.frame.size.height + description.frame.origin.x)];
	
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	if ([[[request URL] absoluteString] isEqualToString:@"about:blank"]) {
		
		
		return YES;
	} 
	else {
		BrowserViewController *browser = [[BrowserViewController alloc] initWithString:[[request URL]absoluteString]];
		
		[[self navigationController] presentModalViewController:browser animated:YES];
		[browser release];
		return NO;
	}

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
