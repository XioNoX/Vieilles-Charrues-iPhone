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
	
	BOOL parsingSuccessTwit = NO;
	BOOL parsingSuccessFB = NO;
	BOOL parsingSuccessVC = NO;
	
	NSURL *url = [NSURL URLWithString: TWITSOURCE];
	
	VCNewsParser* parser = [[VCNewsParser alloc] initWithContentsOfURL:url andType:@"Twitter"];
	[parser setDelegate:parser];
	parsingSuccessTwit = [parser parse];
	
	
	url = [NSURL URLWithString:FBSOURCE];
	
	[parser initWithContentsOfURL:url andType:@"Facebook"];
	
	parsingSuccessFB = [parser parse];
	
	url = [NSURL URLWithString: VCSOURCE];
	[parser initWithContentsOfURL:url andType:@"VieillesCharrues"];
	
	
	
	parsingSuccessVC = [parser parse];
	
	BOOL parsingSuccess = parsingSuccessFB && parsingSuccessVC && parsingSuccessTwit;
	
	BOOL totalFail = !parsingSuccessFB && !parsingSuccessVC && !parsingSuccessTwit;
	
	if(totalFail) {
		[delegate majEnded:-1];
	}
	else {
		if(parsingSuccess)
		{
			[[VCDataBaseController sharedInstance] mettreAJourNews:parser.listeNews];
			
			[delegate majEnded:0];
		}
		else 
		{
			if (parsingSuccessFB)
				
				[[VCDataBaseController sharedInstance] mettreAJourNewsFB:parser.listeNews];
			else {
				[delegate majEnded:1];
			}
			
			if (parsingSuccessTwit) {
				[[VCDataBaseController sharedInstance] mettreAJourNewsTwit:parser.listeNews];
			}
			else {
				[delegate majEnded:2];
			}
			
			if (parsingSuccessVC) {
				[[VCDataBaseController sharedInstance] mettreAJourNewsVC:parser.listeNews];
			}
			else {
				[delegate majEnded:3];
			}
			
			
			
		}
		
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
