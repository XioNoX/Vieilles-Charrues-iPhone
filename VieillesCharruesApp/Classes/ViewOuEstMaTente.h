//
//  ViewOuEstMaTente.h
//  VieillesCharruesApp
//
//  Created by ToM on 17/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCDataBaseController.h"
#import "VCCLLocationController.h"


@interface ViewOuEstMaTente : UITableViewController 
{
	VCDataBaseController *base;
	NSArray *listeTentes;
	IBOutlet UIBarButtonItem *boutonPlus;
	IBOutlet UITextField *textFieldNomTente;
	IBOutlet UIView *cacheBouton;
	IBOutlet UIActivityIndicatorView *indicateur;
	
	VCTente *nouvelleTente;
	VCCLLocationController *locationController;
	
	
	NSString *nomTente;
	CGFloat longi;
	CGFloat lati;
	
}
-(IBAction) ajouterTente;
-(IBAction) supprimerTente:(UIButton*)sender;
@end
