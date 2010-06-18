//
//  VCConcertParser.h
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VCConcertParser : NSXMLParser
{
	NSMutableArray *listeConcert;
	NSNumber *idConcert;
	NSNumber *idJour;
	NSNumber *idScene;
	NSNumber *idGroupe;
	NSString *heureDeb;
	NSString *heureEnd;
	BOOL toRecord;
	NSMutableString *buildingElement;
}

@property (readonly) NSMutableArray* listeConcert;

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
