//
//  TableViewControllerNews.h
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "VCDataBaseController.h"
#import "VCFluxUpdater.h"

@interface TableViewControllerNews : UITableViewController <VCFluxUpdaterDelegate>
{
	NSArray *listeNews;
	VCDataBaseController *dataBase;
	IBOutlet UIBarButtonItem *boutonMiseAjour;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	VCFluxUpdater* maj;
	UIView		*loadingMajView;
}

@property (nonatomic, retain) VCFluxUpdater *maj
;
- (IBAction)mettreAJour:(id)sender;

@end
