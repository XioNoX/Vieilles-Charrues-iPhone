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

#import "CellDetailHeader.h"
#import "VCUtils.h"
#import "BrowserViewController.h"

@implementation CellDetailHeader

@synthesize controller;

-(void)initWithArtiste:(VCArtiste*)artiste
{
	//verification de l'existance de l'image de l'artiste dans les fichiers locaux, sinon telechargement et enregistrement de l'image	
	NSData *imageData;
	NSString *nomImageArtiste  = [NSString stringWithFormat:@"Artiste%i.jpg", [artiste.ident intValue]];
	//NSString *picturesDirectory = [NSString stringWithFormat:@"%@/ImagesArtistes", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
	//NSString *filePath = [NSString stringWithFormat:@"%@/%@",picturesDirectory, nomImageArtiste];
	

	imageData = [NSData dataWithContentsOfFile:[VCUtils getImageArtiste:nomImageArtiste]];  
	
	UIImage *imageArtiste = [UIImage imageWithData:imageData];
	
	nomGroupe.text =artiste.nom;
	genre.text = artiste.genre;
	origine.text = artiste.origine;
	
	NSMutableString *htmlStr = [[NSMutableString alloc] init];
	[htmlStr appendString:@"<html><head><style> body {margin:0px; font-family:verdana; font-size:12px;} </style></head><body>"];
	[htmlStr appendString:artiste.lien];
	[htmlStr appendString:@"</body></html>"];
	
	[site loadHTMLString: htmlStr baseURL:nil];
	[site setDelegate:self];
	
	[imageGroupe setImage:imageArtiste];
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	if ([[[request URL] absoluteString] isEqualToString:@"about:blank"]) {
		return YES;
	}
	else {
		BrowserViewController *browser = [[BrowserViewController alloc] initWithString:[[request URL]absoluteString]];
		
		
		[[self controller] presentModalViewController:browser animated:YES];
		[browser release];
		return NO;
	}
	

	
}

-(void) dealloc {
	[genre release];
	[imageGroupe release];
	[nomGroupe release];
	[origine release];
	[site release];
	
	[super dealloc];
}

@end
