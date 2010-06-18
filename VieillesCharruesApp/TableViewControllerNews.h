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

@interface TableViewControllerNews : UITableViewController 
{
	NSArray *listeNews;
	VCDataBaseController *dataBase;
	IBOutlet UIBarButtonItem *boutonMiseAjour;
	IBOutlet UIActivityIndicatorView *activityIndicator;
}

- (IBAction)mettreAJour:(id)sender;
@end
