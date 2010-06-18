//
//  VCDataBaseController.h
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "VCConcert.h"
#import "VCNews.h"
#import "VCArtiste.h"
#import "VCTente.h"

@interface VCDataBaseController : NSObject {
	sqlite3 *base;
	NSString *filePath;
}

+ (VCDataBaseController*)sharedInstance;

//-(id) initWithFilePath : (NSString*) path;


-(void)open;

-(void)close;

-(void) ajouterConcert:(NSNumber*) idConcert 
				duJour:(NSNumber*) idJour 
		   surLaScene :(NSNumber*) idScene 
			  duGroupe:(NSNumber*)idGroupe 
		   commencantA:(NSString*) heureDebut 
		   finnissantA:(NSString*) heureFin;

-(void)ajouterNews:(VCNews*) nouvelle;

-(void) ajouterConcert:(VCConcert*) concert;

-(void) mettreConcertEnFavori:(int)idConcert;

-(void) supprimerConcertDesFavoris:(int) idConcert;

-(void) ajouterGroupe:(VCArtiste*) artiste;

-(void) ajouterTente:(VCTente*) tente;

-(int) getMaxIdTente;

-(NSArray*) getTentes;

-(void) supprimerTente:(int)idTente;

-(NSArray*) getConcertsDuJour:(NSNumber *)idJour;

-(NSArray*) getConcertsFavoris;

-(VCConcert*) getConcertDuGroupe:(int)idGroupe;

-(NSArray*) getConcertsDuGroupe:(NSNumber*) idArtiste;

-(NSArray*) getNews;

-(VCNews*) getNewsWithId:(int)idNews;

-(VCArtiste *) getArtiste:(int) idArtiste;

-(void)updateImageArtiste:(int)idArtiste;

-(NSMutableDictionary*) getListeArtistes;

-(NSArray*) getListeArtistesOrdered;

-(void) mettreAJourNews:(NSArray *)listeNews;

-(void) mettreAJourArtistes:(NSArray *)listeArtistes;

-(void) mettreAJourConcert:(NSArray*)listeConcert;

@end
