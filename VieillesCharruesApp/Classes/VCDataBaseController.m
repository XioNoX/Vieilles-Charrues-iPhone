//
//  VCDataBaseController.m
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCDataBaseController.h"
#import "constantes.h"

#define TABLE_CONCERTS @"concert"
#define TABLE_ARTISTES @"artiste"
#define TABLE_NEWS @"news"
#define TABLE_TENTES @"mesTentes"

static VCDataBaseController *sharedInstance = nil;

@implementation VCDataBaseController



-(id) initWithFilePath : (NSString*) path
{
	filePath = [NSString stringWithString:path];
	@try {
		
		[self open];
	}
	@catch (NSString * e) {
		NSLog(@"%@", e);
	}
	return self;
}



+ (VCDataBaseController*)sharedInstance 
{ 
    @synchronized(self) 
    { 
        if (sharedInstance == nil) 
		{
			NSString *bddInitiale =[[NSBundle mainBundle] pathForResource:@"VCdataBase" ofType:@"db"];
			NSFileManager *managerFichier = [[NSFileManager alloc]init];
			NSString *bddDestination = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/VCdataBase.db"];
			
			NSError *erreur = [[NSError alloc]init];
			
			//if(![managerFichier removeItemAtPath:bddDestination error:&erreur]) NSLog(@"%@", [erreur localizedDescription]);
			if(![managerFichier fileExistsAtPath:bddDestination])
			{
				if(![managerFichier copyItemAtPath:bddInitiale toPath:bddDestination error:&erreur]) NSLog(@"%@", [erreur localizedDescription]);
			}
			
			[erreur release];
			[managerFichier release];
			
			sharedInstance = [[VCDataBaseController alloc] initWithFilePath:bddDestination]; 
		}
    } 
    return sharedInstance; 
}

-(void)open
{
	if(sqlite3_open([filePath UTF8String], &base) != SQLITE_OK)
	{
		@throw [NSString stringWithCString:sqlite3_errmsg(base) encoding:NSUTF8StringEncoding];
	}
}

//permet d'executer un requete de modification de base
-(void)executeRequete:(const char*) requete
{
	//[self open];
	
	BOOL succes = sqlite3_exec(base, requete, NULL, NULL, NULL) == SQLITE_OK;
	if(!succes)
	{
		NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(base) encoding:NSUTF8StringEncoding]);
	}
	
	//[self close];
}

-(BOOL) executeQuery:(const char *)requete withStatement:(sqlite3_stmt **)state
{
	//[self open];
	
	BOOL retour = sqlite3_prepare_v2(base, requete, -1, state, NULL)==SQLITE_OK;
	
	
	if(!retour)
	{
		NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(base) encoding:NSUTF8StringEncoding]);
	}
	
	//[self close];
	
	return retour;
}

-(void) mettreConcertEnFavori:(int) idConcert
{
	const char * req = [[NSString stringWithFormat:@"insert into favori (idConcert) values (%i);", idConcert] UTF8String];
	[self executeRequete:req];
}

-(void) supprimerConcertDesFavoris:(int)idConcert
{
	const char * req = [[NSString stringWithFormat:@"delete from favori where idConcert = %i;", idConcert] UTF8String];
	[self executeRequete:req];
}


-(void) ajouterConcert:(NSNumber*) idConcert 
				duJour:(NSNumber*) idJour 
		   surLaScene :(NSNumber*) idScene 
			  duGroupe:(NSNumber*) idGroupe 
		   commencantA:(NSString*) heureDebut 
		   finnissantA:(NSString*) heureFin
{
	const char* req = [[NSString stringWithFormat:@"insert into %@ values (%i, %i, %i, %i, '%@', '%@')",TABLE_CONCERTS, [idConcert intValue], [idJour intValue], [idScene intValue], [idGroupe intValue], heureDebut, heureFin] UTF8String];
	[self executeRequete: req];
}

-(void)ajouterNews:(VCNews*)nouvelle
{
	NSDateFormatter *formateurDeDate = [[NSDateFormatter alloc] init];
	[formateurDeDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	[formateurDeDate setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	NSString *jour = [formateurDeDate stringFromDate:nouvelle.date];
	
	//remplacement des caractères pouvant poser problème dans la base de données
	NSMutableString *titreASecuriser = [[NSMutableString alloc] initWithString:nouvelle.titre];
	NSMutableString *descriptionAScuriser = [[NSMutableString alloc] initWithString:nouvelle.description];
	[descriptionAScuriser replaceOccurrencesOfString:@"'" withString:@"''" options:NSLiteralSearch range:NSMakeRange(0, [descriptionAScuriser length])];
	[titreASecuriser replaceOccurrencesOfString:@"'" withString:@"''" options:NSLiteralSearch range:NSMakeRange(0, [titreASecuriser length])];
	
	[formateurDeDate release];
	
	const char* req = [[NSString stringWithFormat:@"insert into %@ (source, titre, description, date)   values ('%@', '%@', '%@', '%@')", TABLE_NEWS, nouvelle.source, titreASecuriser, descriptionAScuriser, jour] UTF8String];
	
	[descriptionAScuriser release];
	[titreASecuriser release];
	
	
	[self executeRequete: req];

}

-(void) ajouterConcert:(VCConcert *)concert
{
	const char* req = [[NSString stringWithFormat:@"insert into %@ values (%i, %i, %i, %i, '%@', '%@')", TABLE_CONCERTS, [concert.idConcert intValue], [concert.idJour intValue], [concert.idScene intValue], [concert.idArtiste intValue], concert.heureDebut , concert.heureFin] UTF8String];
	[self executeRequete: req];
}

-(void) ajouterGroupe:(VCArtiste*) artiste
{
	
	//modification des champs pouvant poser problèmes dans la base de données (remplacement des ' par '')
	NSMutableString *desc = [NSMutableString stringWithString:artiste.description];
	[desc replaceOccurrencesOfString:@"'" withString:@"''" options:NSLiteralSearch range:NSMakeRange(0, [desc length])];
	
	
	NSMutableString *groupe = [NSMutableString stringWithString:artiste.nom];
	[groupe replaceOccurrencesOfString:@"'" withString:@"''" options:NSLiteralSearch range:NSMakeRange(0, [groupe length])];
	
	const char* req = [[NSString stringWithFormat:@"insert into %@ values (%i,'%@','%@','%@','%@','%@','%@')", TABLE_ARTISTES, [artiste.ident intValue], groupe, desc, artiste.genre, artiste.lien, artiste.origine, artiste.image] UTF8String];
	[self executeRequete: req];
}

-(void) ajouterTente:(VCTente*) tente
{
	
	const char* req = [[NSString stringWithFormat:@"insert into %@ values (%i,'%@', %f, %f)", TABLE_TENTES, tente.identifiant, tente.nom, tente.longitude, tente.latitude] UTF8String];
	[self executeRequete: req];
	
}

-(int) getMaxIdTente
{
	const char* req = [[NSString stringWithFormat:@"select max(id) from %@;",TABLE_TENTES] UTF8String];
	
	
	sqlite3_stmt *statement;
	[self executeQuery:req withStatement:&statement];
	
	sqlite3_step(statement);
	
	return sqlite3_column_int(statement, 0);
}

-(NSArray*) getTentes
{
	const char* req = [[NSString stringWithFormat:@"select * from %@;",TABLE_TENTES] UTF8String];
	NSMutableArray *retour = nil;
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	
	if (succes) {
		
		retour = [[NSMutableArray alloc] init];
		while(sqlite3_step(statement) == SQLITE_ROW)
		{
			VCTente *nouvelleTente = [[VCTente alloc] initWithStatement:statement];
			[retour addObject:nouvelleTente];
			[nouvelleTente release];
		}
		
		//sqlite3_clear_bindings(statement);
	}
	return [retour autorelease];
	
}

-(void) supprimerTente:(int)idTente
{
	const char * req = [[NSString stringWithFormat:@"delete from %@ where id = %i;", TABLE_TENTES, idTente] UTF8String];
	[self executeRequete:req];
}

-(NSArray*) getConcertsDuJour:(NSNumber*) idJour
{
	NSMutableArray *retour = [[[NSMutableArray alloc] init] autorelease];
	const char* req = [[NSString stringWithFormat:@"select * from %@ c left outer join favori f on c.idConcert=f.idConcert where c.idJour = '%i' order by c.idScene;",TABLE_CONCERTS , [idJour intValue]] UTF8String];
	
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	
	if(succes)
	{
		
		NSMutableArray *listeConcertScene = [[NSMutableArray alloc] init];
		int scenePrec;
		BOOL first = YES;
		while (sqlite3_step(statement)==SQLITE_ROW) 
		{
			int idScene = sqlite3_column_int(statement, 2);
			if(first) 
			{
				scenePrec = idScene;
				first = NO;
			}
			if(idScene != scenePrec)
			{
				[retour addObject:listeConcertScene];
				[listeConcertScene release];
				listeConcertScene = [[NSMutableArray alloc] init];
			}
			VCConcert *nouveauConcert = [[VCConcert alloc] initFromConcertStatement:statement];
			[listeConcertScene addObject:nouveauConcert];
			[nouveauConcert release];
			scenePrec = idScene;
		}
		//ajout de la dernière scene
		[retour addObject:listeConcertScene];
		[listeConcertScene release];
	}
	
	return retour;
}

-(NSArray*) getConcertsDuGroupe:(NSNumber*) idArtiste
{
	NSMutableArray *retour = [[[NSMutableArray alloc] init] autorelease];
	const char* req = [[NSString stringWithFormat:@"select * from %@ where idGroupe = '%i' order by idJour;",TABLE_CONCERTS , [idArtiste intValue]] UTF8String];
	
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	
	if(succes)
	{
		while (sqlite3_step(statement)==SQLITE_ROW) 
		{
			VCConcert *nouveauConcert = [[VCConcert alloc] initFromConcertStatement:statement];
			[retour addObject:nouveauConcert];
			[nouveauConcert release];
		}
	}
	
	return retour;
}

-(NSArray*) getConcertsFavoris
{
	NSMutableArray *retour = [[[NSMutableArray alloc] init] autorelease];
	const char* req = [[NSString stringWithFormat:@"select * from %@ c join favori f on c.idConcert=f.idConcert order by idJour;",TABLE_CONCERTS ] UTF8String];
	
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	
	if(succes)
	{
		
		NSMutableArray *listeConcertScene = [[NSMutableArray alloc] init];
		int jourPrec;
		BOOL first = YES;
		while (sqlite3_step(statement)==SQLITE_ROW) 
		{
			int idJour = sqlite3_column_int(statement, 1);
			if(first) 
			{
				jourPrec = idJour;
				first = NO;
			}
			if(idJour != jourPrec)
			{
				[retour addObject:listeConcertScene];
				[listeConcertScene release];
				listeConcertScene = [[NSMutableArray alloc] init];
			}
			VCConcert *nouveauConcert = [[VCConcert alloc] initFromConcertStatement:statement];
			[listeConcertScene addObject:nouveauConcert];
			[nouveauConcert release];
			jourPrec = idJour;
		}
		//ajout de la dernière scene
		[retour addObject:listeConcertScene];
		[listeConcertScene release];
	}
	
	return retour;
}

-(NSArray*) getNews
{
	NSMutableArray* retour = [[[NSMutableArray alloc] init] autorelease];
	
	const char* req = [[NSString stringWithString:@"select * from news order by julianday(date) desc;"] UTF8String];
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	
	if(succes)
	{
		while (sqlite3_step(statement)==SQLITE_ROW) 
		{
			VCNews *nouvelle = [[VCNews alloc] initWithStatement:statement];
			[retour addObject:nouvelle];
			[nouvelle release];
		}
	}
	
	return retour;
}

-(VCNews*) getNewsWithId:(int) idNews
{
	VCNews *retour = nil;
	const char* req = [[NSString stringWithFormat:@"select * from %@ where idNews = '%i';",TABLE_NEWS, idNews] UTF8String];
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	if(succes)
	{
		if(sqlite3_step(statement)) 
		{
			retour = [[[VCNews alloc] initWithStatement:statement] autorelease];
		}
	}
	
	return retour;
}

-(VCArtiste *) getArtiste:(int)idArtiste
{
	VCArtiste *retour = nil;
	const char* req = [[NSString stringWithFormat:@"select * from %@ where id = '%i';",TABLE_ARTISTES, idArtiste] UTF8String];
	
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	if(succes)
	{
		if(sqlite3_step(statement)) 
		{
			retour = [[[VCArtiste alloc] initWithSQLStatement:statement] autorelease];
		}
	}
	
	return retour;
}

-(NSDictionary*) getListeArtistes
{
	NSMutableDictionary *retour = [[[NSMutableDictionary alloc] init] autorelease];
	const char* req = [[NSString stringWithFormat:@"select * from %@ order by nom", TABLE_ARTISTES] UTF8String];
	
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	
	if(succes)
	{
		while (sqlite3_step(statement)==SQLITE_ROW) 
		{
			NSString *idGroupe = [NSString stringWithCString:(char*)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
			NSString *nomgroupe = [NSString stringWithCString:(char*)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
			
			[retour setObject:nomgroupe forKey:idGroupe];
		}
	}
	
	return (NSDictionary*)retour;
	
}

//permet d'obtenir la liste complete des artiste ordonnées par nom d'artiste
-(NSArray*) getListeArtistesOrdered
{
	NSMutableArray *retour = [[[NSMutableArray alloc] init] autorelease];
	const char* req = [[NSString stringWithFormat:@"select * from %@ order by upper(nom)", TABLE_ARTISTES] UTF8String];
	
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	
	if(succes)
	{
		while (sqlite3_step(statement)==SQLITE_ROW) 
		{
			VCArtiste *artiste = [[VCArtiste alloc] initWithSQLStatement:statement];
			
			[retour addObject:artiste];
			[artiste release];
		}
	}
	
	return (NSArray*)retour;
	
}

-(VCConcert*) getConcertDuGroupe:(int) idGroupe
{
	VCConcert *retour = nil;
	const char* req = [[NSString stringWithFormat:@"select * from %@ c left outer join favori f on c.idConcert=f.idConcert where idGroupe = '%i';",TABLE_CONCERTS, idGroupe] UTF8String];
	
	
	sqlite3_stmt *statement;
	BOOL succes = [self executeQuery:req withStatement:&statement];
	if(succes)
	{
		if(sqlite3_step(statement)) 
		{
			retour = [[[VCConcert alloc] initFromConcertStatement:statement] autorelease];
		}
	}
	return retour;
}


-(void) mettreAJourNews:(NSArray *)listeNews
{
	const char * req = [[NSString stringWithFormat:@"delete from %@;", TABLE_NEWS] UTF8String];
	[self executeRequete:req];
	for(VCNews* nouvelle in listeNews)
	{
		[self ajouterNews:nouvelle];
	}
}

-(void) mettreAJourNewsFB:(NSArray *)listeNewsFB {
	const char * req = [[NSString stringWithFormat:@"delete from %@ where source = 'Facebook'", TABLE_NEWS] UTF8String];
	[self executeRequete:req];
	for(VCNews* nouvelle in listeNewsFB)
	{
		[self ajouterNews:nouvelle];
	}
}

-(void) mettreAJourNewsTwit:(NSArray *)listeNewsTwit {
	const char * req = [[NSString stringWithFormat:@"delete from %@ where source = 'Twitter'", TABLE_NEWS] UTF8String];
	[self executeRequete:req];
	for(VCNews* nouvelle in listeNewsTwit)
	{
		[self ajouterNews:nouvelle];
	}
}

-(void) mettreAJourNewsVC:(NSArray *)listeNewsVC {
	const char * req = [[NSString stringWithFormat:@"delete from %@  where source = 'VieillesCharrues'", TABLE_NEWS] UTF8String];
	[self executeRequete:req];
	for(VCNews* nouvelle in listeNewsVC)
	{
		[self ajouterNews:nouvelle];
	}
}

-(void) mettreAJourArtistes:(NSArray*) listeArtistes
{
	
	const char * req = [[NSString stringWithFormat:@"delete from %@;", TABLE_ARTISTES] UTF8String]; 
	[self executeRequete:req]; //suppression des anciens groupes enregistrés dans la base
	for(VCArtiste *artiste in listeArtistes)
	{
		[self ajouterGroupe: artiste];
	}
	
}

-(void)updateImageArtiste:(int)idArtiste
{
	
	const char *req = [[NSString stringWithFormat:@"update %@ set image='Artiste%i' where id = %i;", TABLE_ARTISTES, idArtiste, idArtiste] UTF8String];
	
	[self executeRequete:req];
	
}

-(void) mettreAJourConcert:(NSArray*)listeConcert
{
	const char * req = [[NSString stringWithFormat:@"delete from %@;", TABLE_CONCERTS] UTF8String];
	[self executeRequete:req]; //suppression des anciens concert enregistrés dans la base
	for(VCConcert *conc in listeConcert)
	{
		[self ajouterConcert:conc];
	}
}


-(void)close
{
	sqlite3_close(base);
}

@end
