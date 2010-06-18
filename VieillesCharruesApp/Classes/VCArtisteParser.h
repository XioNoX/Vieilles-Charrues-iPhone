//
//  VCArtisteParser.h
//  VieillesCharruesApp
//
//  Created by ToM on 29/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VCArtisteParser : NSXMLParser
{
	NSMutableArray *listeArtistes;
	NSMutableString *buildingElement;
	
	BOOL aTraiter;
	
	NSNumber *idArtiste;
	NSString *nomArtiste;
	NSString *description;
	NSString *image;
	NSString *lien;
	NSString *origine;
	NSString *genre;
	
}

@property (retain, nonatomic) NSArray *listeArtistes;

@end
