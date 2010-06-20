//
//  TableViewControllerArtistes.h
//  VieillesCharruesApp
//
//  Created by ToM on 29/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCDataBaseController.h"


@interface TableViewControllerArtistes : UIViewController <UITableViewDelegate, UITableViewDataSource> 
{
	UITableView					*artistesTableView;
	
	VCDataBaseController		*dataBase;
	NSMutableArray				*arrayOfLetters;
	NSArray						*arrayOfBandOrdered;
	NSMutableDictionary			*BandSorted;
}

-(void)createDictionary;

@end
