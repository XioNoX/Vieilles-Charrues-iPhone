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
	
	VCNewsParser* parserTwit = [[VCNewsParser alloc] initWithContentsOfURL:url andType:@"Twitter"];
	[parserTwit setDelegate:parserTwit];
	parsingSuccessTwit = [parserTwit parse];
	
	
	url = [NSURL URLWithString:FBSOURCE];
	
	VCNewsParser *parserFB = [[VCNewsParser alloc] initWithContentsOfURL:url andType:@"Facebook"];
	[parserFB setDelegate:parserFB];
	parsingSuccessFB = [parserFB parse];
	
	url = [NSURL URLWithString: VCSOURCE];
	VCNewsParser *parserVC = [[VCNewsParser alloc] initWithContentsOfURL:url andType:@"VieillesCharrues"];
	[parserVC setDelegate:parserVC];
	parsingSuccessVC = [parserVC parse];
	
	
	BOOL parsingSuccess = parsingSuccessFB && parsingSuccessVC && parsingSuccessTwit;
	
	BOOL totalFail = !parsingSuccessFB && !parsingSuccessVC && !parsingSuccessTwit;
	
	if(totalFail) {
		[delegate majEnded:-1];
	}
	else {
		if(parsingSuccess)
		{
			NSMutableArray	*arrayOfNews = [[NSMutableArray alloc] init];
			[arrayOfNews addObjectsFromArray:parserFB.listeNews];
			[arrayOfNews addObjectsFromArray:parserVC.listeNews];
			[arrayOfNews addObjectsFromArray:parserTwit.listeNews];
			[[VCDataBaseController sharedInstance] mettreAJourNews:arrayOfNews];
			
			[delegate majEnded:0];
		}
		else 
		{
			if (parsingSuccessFB)
				
				[[VCDataBaseController sharedInstance] mettreAJourNewsFB:parserFB.listeNews];
			else {
				[delegate majEnded:1];
			}
			
			if (parsingSuccessTwit) {
				[[VCDataBaseController sharedInstance] mettreAJourNewsTwit:parserTwit.listeNews];
			}
			else {
				[delegate majEnded:2];
			}
			
			if (parsingSuccessVC) {
				[[VCDataBaseController sharedInstance] mettreAJourNewsVC:parserVC.listeNews];
			}
			else {
				[delegate majEnded:3];
			}
			
			
			
		}
		
	}
	
	[parserFB release];
	[parserVC release];
	[parserTwit release];
	
	
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
