//
//  MAJ.m
//  VieillesCharruesApp
//
//  Created by Thomas Belin on 18/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCFluxUpdater.h"
#import "VCDataBaseController.h"
#import "VCArtisteParser.h"
#import "VCConcertParser.h"

@implementation VCFluxUpdater

@synthesize delegate;

-(void)miseAjourNews {
	
	BOOL parsingSuccess = NO;
	
	NSURL *url = [NSURL URLWithString: TWITSOURCE];
	
	VCNewsParser* parser = [[VCNewsParser alloc] initWithContentsOfURL:url andType:@"Twitter"];
	[parser setDelegate:parser];
	parsingSuccess = [parser parse];
	
	
	
	url = [NSURL URLWithString:FBSOURCE];
	[parser initWithContentsOfURL:url andType:@"Facebook"];
	
	parsingSuccess = parsingSuccess && [parser parse];
	
	url = [NSURL URLWithString: VCSOURCE];
	[parser initWithContentsOfURL:url andType:@"VieillesCharrues"];
	
	parsingSuccess = parsingSuccess && [parser parse];
	
	
	if(parsingSuccess)
	{
		[[VCDataBaseController sharedInstance] mettreAJourNews:parser.listeNews];
		
		[delegate majEnded:0];
	}
	else 
	{
		UIAlertView *errorMessage = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Une erreur s'est produite lors de la récupération des actualités. Veuillez véfifier vos paramètres de connexion et reessayer" delegate:nil cancelButtonTitle:@"Fermer" otherButtonTitles:nil];
		[errorMessage show];
		[errorMessage release];
		[delegate majEnded:1];
	}
	
	
	[parser release];
	
	
}

-(void) miseAjourProg {
	
	NSURL *urlProg = [NSURL URLWithString: SOURCE_XML_CONCERTS];
	NSURL *urlArtistes = [NSURL URLWithString:SOURCE_XML_ARTISTES];
	
	VCConcertParser* parserProg = [[VCConcertParser alloc] initWithContentsOfURL:urlProg];
	[parserProg setDelegate:parserProg];
	
	BOOL parsingSuccess = NO;
	
	parsingSuccess = [parserProg parse];
	if(!parsingSuccess){
		//NSLog(@"erreur de parsing du flux de la programmation");
	}
	
	VCArtisteParser* parserArt = [[VCArtisteParser alloc] initWithContentsOfURL:urlArtistes];
	[parserArt setDelegate:parserArt];
	
	parsingSuccess = parsingSuccess && [parserArt parse];
	
	if(!parsingSuccess){
		NSLog(@"erreur de parsing du flux des artistes");
	}
	
	if(parsingSuccess)
	{
		VCDataBaseController *dataBase = [VCDataBaseController sharedInstance];
		[dataBase mettreAJourConcert:parserProg.listeConcert];
		[dataBase mettreAJourArtistes:parserArt.listeArtistes];
		
		[delegate majEnded:0];
	}
	else 
	{
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"erreur" message:@"Une erreur s'est produite lors de la récupération de le programmation. Verifiez vos paramètres de connexion et recommencez" delegate:nil cancelButtonTitle:@"fermer" otherButtonTitles:nil];
		
		[message show];
		[message release];
		
		[delegate majEnded:1];
	}
	[parserProg release];
	
	
	
}

@end
