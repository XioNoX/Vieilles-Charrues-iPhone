//
//  TableViewDetailsConcert.h
//  VieillesCharruesApp
//
//  Created by ToM on 08/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCArtiste.h"
#import "VCConcert.h"


@interface TableViewDetailsConcert : UITableViewController
{
	VCArtiste *artiste;
	NSArray *listeConcert;
	NSDictionary *dictionnaireDesScenes;
	NSDictionary *dictionnaireDesJours;
	CGFloat hauteurDescription;
}

-(void) initWithArtiste:(VCArtiste*)artisteCourant Concerts:(NSArray*)concertCourant;

@end
