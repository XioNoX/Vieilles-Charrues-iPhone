//
//  TableViewControllerArtistes.h
//  VieillesCharruesApp
//
//  Created by ToM on 29/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "VCDataBaseController.h"


@interface TableViewControllerArtistes : UITableViewController 
{
	VCDataBaseController *dataBase;
	NSArray *listeConcertParScene;
	NSDictionary *listeGroupe;
	NSArray *arrayOfBandOrdered;
	NSDictionary *tableauDesScenes; //tableau contenant les noms des différentes scenes
}

@property (retain, nonatomic) VCDataBaseController *dataBase;
@property (retain, nonatomic) NSArray *listeConcertParScene;
@property (retain, nonatomic) NSDictionary *listeGroupe;
@property (retain, nonatomic) NSDictionary *tableauDesScenes;

@end
