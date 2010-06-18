//
//  VCConcert.h
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface VCConcert : NSObject 
{
	NSNumber *idConcert;
	NSNumber *idJour;
	NSNumber *idScene;
	NSNumber *idArtiste;
	NSString *heureDebut;
	NSString *heureFin;
	BOOL isFavori;
}

@property (retain, nonatomic) NSNumber *idConcert;
@property (retain, nonatomic) NSNumber *idJour;
@property (retain, nonatomic) NSNumber *idScene;
@property (retain, nonatomic) NSNumber *idArtiste;
@property (retain, nonatomic) NSString *heureDebut;
@property (retain, nonatomic) NSString *heureFin;
@property BOOL isFavori;

-(id)initFromConcertStatement:(sqlite3_stmt*)statement;

-(id)initWithId:(NSNumber*)idenifiantConcert 
		   jour:(NSNumber*) identifiantJour 
		  scene:(NSNumber*) identifiantScene 
		 groupe:(NSNumber*) identifiantGroupe 
		 heureD:(NSString*)heureD 
		 heureF:(NSString*)heureF;


@end
