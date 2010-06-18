//
//  TableViewControllerConcert.h
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCDataBaseController.h"
#import "VCFluxUpdater.h"


@interface TableViewControllerConcert : UITableViewController <VCFluxUpdaterDelegate> {
	IBOutlet UISegmentedControl *selector;
	IBOutlet UIBarButtonItem *boutonMiseAjour;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	
	UIView	*popUpView;
	
	VCDataBaseController *dataBase;
	NSMutableArray *datas;
	NSArray *listeConcertParScene;
	NSDictionary *listeGroupe;
	NSDictionary *tableauDesScenes; //tableau contenant les noms des différentes scenes
}

@property (retain, nonatomic) UIView *popUpView;

- (IBAction)reloadTable;
- (IBAction) changerTri;
- (IBAction)mettreAJour:(id)sender;
@end
