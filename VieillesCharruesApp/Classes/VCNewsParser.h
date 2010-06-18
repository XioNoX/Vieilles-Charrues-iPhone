//
//  VCNewsParser.h
//  VieillesCharruesApp
//
//  Created by ToM on 23/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VCNewsParser : NSXMLParser
{
	NSMutableArray *listeNews;
	NSString *titre;
	NSString *description;
	NSDate *date;
	NSString *source;
	BOOL isDate;
	BOOL isFB;
	BOOL toRecord;
	NSMutableString *buildingElement;
}

@property (readonly) NSMutableArray* listeNews;
@property (retain) NSString* source;

-(id) initWithContentsOfURL:(NSURL *)url andType:(NSString*) type;

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict;

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName;

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string;

@end
