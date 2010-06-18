//
//  VCTente.m
//  VieillesCharruesApp
//
//  Created by ToM on 17/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCTente.h"
#import "VCDataBaseController.h"

@implementation VCTente

@synthesize identifiant, nom, longitude, latitude;

-(id) initWithNom:(NSString *)name longitude:(CGFloat)longi latitude:(CGFloat)lat
{
	identifiant = [[VCDataBaseController sharedInstance] getMaxIdTente] + 1;
	nom = [name retain];
	longitude = longi;
	latitude = lat;
	
	return self;
}

-(id)initWithStatement:(sqlite3_stmt*)statement
{
	identifiant = sqlite3_column_int(statement, 0);
	nom = [[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)] retain];
	longitude = sqlite3_column_double(statement, 2);
	latitude = sqlite3_column_double(statement, 3);
	
	return self;
}

@end
