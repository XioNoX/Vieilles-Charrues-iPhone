//
//  TableViewControllerConcert.h
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCDataBaseController.h"


@interface TableViewControllerConcert : UITableViewController {
	IBOutlet UISegmentedControl *selector;
	IBOutlet UIBarButtonItem *boutonMiseAjour;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	
	VCDataBaseController *dataBase;
	NSMutableArray *datas;
	NSArray *listeConcertParScene;
	NSDictionary *listeGroupe;
	NSDictionary *tableauDesScenes; //tableau contenant les noms des différentes scenes
}
- (IBAction)reloadTable;
- (IBAction) changerTri;
- (IBAction)mettreAJour:(id)sender;
@end
