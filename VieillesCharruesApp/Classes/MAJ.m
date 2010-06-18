//
//  MAJ.m
//  VieillesCharruesApp
//
//  Created by Thomas Belin on 18/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MAJ.h"
#import "VCDataBaseController.h"

@implementation MAJ

@synthesize delegate;

-(void)maj{
	
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
	
	
	
	//if(dataBase == nil) dataBase = [VCDataBaseController sharedInstance];
	
	if(parsingSuccess)
	{
		//[self popUpLoadingWithMessage:@"Actualités mises à jour"];
		[[VCDataBaseController sharedInstance] mettreAJourNews:parser.listeNews];
	}
	else 
	{
		UIAlertView *errorMessage = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Une erreur s'est produite lors de la récupération des actualités. Veuillez véfifier vos paramètres de connexion et reessayer" delegate:nil cancelButtonTitle:@"Fermer" otherButtonTitles:nil];
		[errorMessage show];
		[errorMessage release];
	}
	
	
	[parser release];
	
	
	
	[delegate majEnded:[NSNumber numberWithInt:1]];
}

@end
