//
//  VCNewsParser.m
//  VieillesCharruesApp
//
//  Created by ToM on 23/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCNewsParser.h"
#import "VCNews.h"
#import "VCHTMLRemover.h"


@implementation VCNewsParser

@synthesize listeNews, source;

-(id) initWithContentsOfURL:(NSURL *)url andType:(NSString*) type
{
	[self initWithContentsOfURL:url];
	source =[type retain];
	return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{
	
	if ([elementName isEqualToString:@"entry"]) 
	{
		isFB = YES;
	}
	if([elementName isEqualToString:@"title"]) 
	{
		toRecord = YES;
	}
	else if([elementName isEqualToString:@"description"] || [elementName isEqualToString:@"content"]) toRecord = YES;
	else if([elementName isEqualToString:@"pubDate"] || [elementName isEqualToString:@"updated"]) {toRecord = YES; isDate = YES;}
}

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	if([elementName isEqualToString:@"title"])
	{
		titre = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
	else if([elementName isEqualToString:@"description"] || [elementName isEqualToString:@"content"])
	{
		[VCHTMLRemover removeHTMLFromString:buildingElement];
		description = [buildingElement retain];
		[buildingElement release];
		buildingElement = nil;
	}
	else if([elementName isEqualToString:@"pubDate"] || [elementName isEqualToString:@"updated"])
	{
		NSDateFormatter *formateurDeDate = [[NSDateFormatter alloc] init];
		if([elementName isEqualToString:@"pubDate"])
		{
			[formateurDeDate setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss vvvv"];
		}
		else 
		{
			[formateurDeDate setDateFormat:@"yyyy-M-d HH:mm:ss"];
		}

		[formateurDeDate setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		NSDate *dat = [formateurDeDate dateFromString:buildingElement];
		[formateurDeDate release];
		[buildingElement release];
		buildingElement = nil;
		date = [dat retain];
	}
	else if([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"] )
	{
		if(listeNews == nil) listeNews = [[NSMutableArray alloc] init];
		VCNews *nouvelle = [[VCNews alloc] initWithObjects:[NSNumber numberWithInt:0] titre:titre descripion:description from:source de:date];
		[titre release];
		[description release];
		[date release];
		[listeNews addObject:nouvelle];
		[nouvelle release];
	}
	
	toRecord = NO;
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
	if(toRecord)
	{
		if (buildingElement == nil) buildingElement = [[NSMutableString alloc] init];
		[buildingElement appendString:string];
		if(isDate && isFB) 
		{
			[buildingElement replaceOccurrencesOfString:@"T" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
			isDate = NO;
		} 
		[buildingElement replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
		[buildingElement replaceOccurrencesOfString:@"\t" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
		[buildingElement replaceOccurrencesOfString:@"  " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [buildingElement length])];
	}
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	
	NSLog(@"%@,  %i, %@",[parseError localizedDescription], [parser lineNumber], parseError);
}

@end
