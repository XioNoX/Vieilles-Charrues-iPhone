//
//  VCArtiste.m
//  VieillesCharruesApp
//
//  Created by ToM on 29/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCArtiste.h"


@implementation VCArtiste

@synthesize ident, nom, description, image, lien, origine, genre;

-(id) initWithSQLStatement:(sqlite3_stmt *)statement
{
	
	int identifiantArtiste = sqlite3_column_int(statement, 0);
	const char *nomArtiste = (char*)sqlite3_column_text(statement, 1);
	const char *desc = (char*)sqlite3_column_text(statement, 2);
	const char *type = (char*)sqlite3_column_text(statement, 3);
	const char *link = (char*)sqlite3_column_text(statement, 4);
	const char *orig = (char*)sqlite3_column_text(statement, 5);
	const char *img = (char*)sqlite3_column_text(statement, 6);
	
	ident = [[NSNumber numberWithInt:identifiantArtiste] retain];
	nom = [[NSString stringWithCString:nomArtiste encoding:NSUTF8StringEncoding] retain];
	description = [[NSString stringWithCString:desc encoding:NSUTF8StringEncoding] retain];
	genre = [[NSString stringWithCString:type encoding:NSUTF8StringEncoding] retain];
	origine = [[NSString stringWithCString:orig encoding:NSUTF8StringEncoding] retain];
	image = [[NSString stringWithCString:img encoding:NSUTF8StringEncoding] retain];
	lien = [[NSString stringWithCString:link encoding:NSUTF8StringEncoding] retain];
	
	return self;
}

-(id) initWithId:(NSNumber *)identifiant nom:(NSString *)name description:(NSString *)desc genre:(NSString *)genr venantDe:(NSString *)orig image:(NSString *)img lien:(NSString *)link
{
	ident = [identifiant retain];
	nom = [name retain];
	description = [desc retain];
	genre = [genr retain];
	origine = [orig retain];
	image = [img retain];
	lien = [link retain];
	
	return self;
}

@end
