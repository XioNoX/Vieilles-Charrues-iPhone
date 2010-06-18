//
//  VCArtisteParser.m
//  VieillesCharruesApp
//
//  Created by ToM on 29/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCArtisteParser.h"
#import "VCArtiste.h"
#import "VCHTMLRemover.h"
#import "VCUtils.h"


@implementation VCArtisteParser

@synthesize listeArtistes;

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{
	if(listeArtistes == nil) listeArtistes = [[NSMutableArray alloc] init]; //allocation du tableau contenant tous les artistes parsés
	
	//si la balise est "artiste" on enregistre l'identifiant en paramètre de la balise
	if([elementName isEqualToString:@"artiste"])
		idArtiste = [NSNumber numberWithInt:(int)[[attributeDict objectForKey:@"id"] doubleValue]];
	else if([elementName isEqualToString:@"description"])
		aTraiter = YES;
	
}

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	if([elementName isEqualToString:@"artiste"])
	{
		VCArtiste *nouvelArtiste = [[VCArtiste alloc] initWithId:idArtiste nom:nomArtiste description:description genre:genre venantDe:origine image:image lien:lien];
		[listeArtistes addObject:nouvelArtiste];
		[nouvelArtiste release];
	}
	else if([elementName isEqualToString:@"nom"])
	{
		nomArtiste = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
	else if([elementName isEqualToString:@"description"])
	{
		
		[VCHTMLRemover removeHTMLFromString:buildingElement];
		
		
		description = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
	else if([elementName isEqualToString:@"image"])
	{
		image = [buildingElement retain];
		[VCUtils engregisterImageArtisteSiAbsente:[idArtiste intValue] urlImage:image];
		[buildingElement release];
		buildingElement = nil;
	}
	else if([elementName isEqualToString:@"origine"])
	{
		origine = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
	else if([elementName isEqualToString:@"genre"])
	{
		genre = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
	else if([elementName isEqualToString:@"lien"])
	{
		lien = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
	
	if (buildingElement == nil) buildingElement = [[NSMutableString alloc] init];
	[buildingElement appendString:string];
	
	[buildingElement replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
	[buildingElement replaceOccurrencesOfString:@"\t" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
	[buildingElement replaceOccurrencesOfString:@"  " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
	
	//remplacement des espaces de début de ligne
	if([buildingElement length] > 10)
	{
		NSRange rangEspace = [buildingElement rangeOfString:@" " options:NSLiteralSearch range:NSMakeRange(0, 1)];
		if(rangEspace.length != 0)
			[buildingElement replaceCharactersInRange:rangEspace withString:@""];
	}
}

@end
