//
//  VCConcert.m
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCConcert.h"

@implementation VCConcert

@synthesize idConcert, idScene, idArtiste, idJour, heureDebut, heureFin, isFavori;

-(id)initFromConcertStatement:(sqlite3_stmt *)statement
{
	int concert = sqlite3_column_int(statement, 0);
	int jour = sqlite3_column_int(statement, 1);
	int scene = sqlite3_column_int(statement, 2);
	int groupe = sqlite3_column_int(statement, 3);
	const char *heureD = (char*)sqlite3_column_text(statement, 4);
	const char *heureF = (char*)sqlite3_column_text(statement, 5);
	
	idConcert = [[NSNumber numberWithInt:concert] retain];
	idJour = [[NSNumber numberWithInt:jour] retain];
	idScene = [[NSNumber numberWithInt:scene] retain];
	idArtiste = [[NSNumber numberWithInt:groupe] retain];
	heureDebut = [[NSString stringWithCString:heureD encoding:NSUTF8StringEncoding] retain];
	heureFin = [[NSString stringWithCString:heureF encoding:NSUTF8StringEncoding] retain];
	isFavori = sqlite3_column_int(statement, 7) != 0;
	
	return self;
}

-(NSString *) description {
	
	return [NSString stringWithFormat:@"concert de : %@ de %@ à %@", idArtiste, heureDebut, heureFin];
	
}

- (NSComparisonResult) compareConcert:(VCConcert *)concert {
	NSComparisonResult retVal = NSOrderedSame;
	
	int selfValue = [[self heureDebut] intValue];
	int otherValue = [[concert heureDebut] intValue];
	
	if (selfValue < 10) {
		selfValue += 24;
	}
	if (otherValue < 10) {
		otherValue += 24;
	}
	
	if (selfValue > otherValue)
		retVal = NSOrderedAscending;
	else if (selfValue < otherValue) 
		retVal = NSOrderedDescending;
	return retVal;
}

-(id)initWithId:(NSNumber*) idenifiantConcert 
		   jour:(NSNumber*) identifiantJour 
		  scene:(NSNumber*) identifiantScene 
		 groupe:(NSNumber*) identifiantGroupe 
		 heureD:(NSString*) heureD 
		 heureF:(NSString*) heureF
{
	idConcert = [idenifiantConcert retain];
	idJour = [identifiantJour retain];
	idScene = [identifiantScene retain];
	idArtiste = [identifiantGroupe retain];
	heureDebut = [heureD retain];
	heureFin = [heureF retain];
	
	return self;
}

@end
