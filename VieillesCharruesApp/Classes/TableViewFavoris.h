//
//  TableViewFavoris.h
//  VieillesCharruesApp
//
//  Created by ToM on 07/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCDataBaseController.h"

@interface TableViewFavoris : UITableViewController 
{
	NSArray *tableauConcertsFavoris;
	VCDataBaseController *dataBase;
	NSDictionary *dictionnaireDesArtistes;
	NSDictionary *dictionnaireDesScenes;
	NSDictionary *dictionnaireDesJours;
}

@end
