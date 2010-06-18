//
//  VCConcertParser.m
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCConcertParser.h"
#import "VCConcert.h"

@implementation VCConcertParser

@synthesize listeConcert;

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{
	if([elementName isEqualToString:@"jour"])
		idJour = [NSNumber numberWithInt:(int)[[attributeDict objectForKey:@"id"] doubleValue]];
	else if([elementName isEqualToString:@"scene"])
		idScene = [NSNumber numberWithInt:(int)[[attributeDict objectForKey:@"id"] doubleValue]];
	else if([elementName isEqualToString:@"concert"])
		idConcert = [NSNumber numberWithInt:(int)[[attributeDict objectForKey:@"id"] doubleValue]];
	else if([elementName isEqualToString:@"idArtiste"])
	{
		toRecord = YES;
	}
	else if([elementName isEqualToString:@"hDebut"] || [elementName isEqualToString:@"hFin"])
		toRecord = YES;
		
}

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	if([elementName isEqualToString:@"concert"])
	{
		VCConcert *concert = [[VCConcert alloc] initWithId:idConcert jour:idJour scene:idScene groupe:idGroupe heureD:heureDeb heureF:heureEnd];
		if(listeConcert == nil) listeConcert = [[NSMutableArray alloc]init];
		[listeConcert addObject:concert];
		[concert release];
	}
	else if([elementName isEqualToString:@"idArtiste"])
	{
		idGroupe = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
	else if([elementName isEqualToString:@"hDebut"])
	{
		heureDeb = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
	else if([elementName isEqualToString:@"hFin"])
	{
		heureEnd = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
	if(toRecord)
	{
		if (buildingElement == nil) buildingElement = [[NSMutableString alloc] init];
		[buildingElement appendString:string];
		
		[buildingElement replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
		[buildingElement replaceOccurrencesOfString:@"\t" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
		[buildingElement replaceOccurrencesOfString:@"  " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
	}
	toRecord = NO;
}

@end
