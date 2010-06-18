//
//  CellFavori.m
//
//  Created by ToM on 07/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CellFavori.h"

@implementation CellFavori

@synthesize nomGroupe, scene, heure;

-(void) initWithConcert:(VCConcert*)concert
{
	nomGroupe.text = [NSString stringWithFormat:@"artiste %i", [concert.idArtiste intValue]];
	scene.text = [NSString stringWithFormat:@"scene :%i",[concert.idScene intValue]];
	
}

-(void) initWithId:(NSNumber*)ident Groupe:(NSString *)bandName scene:(NSString *)nomScene heure:(NSString *)heureConcert
{
	scene.text = nomScene;
	nomGroupe.text = bandName;
	heure.text = heureConcert;
	self.tag = [ident intValue];
	
}

@end
