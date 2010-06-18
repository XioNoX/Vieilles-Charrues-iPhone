//
//  CellDetailsConcerts.h
//  VieillesCharruesApp
//
//  Created by ToM on 08/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCConcert.h"


@interface CellDetailsConcerts : UITableViewCell 
{
	IBOutlet UILabel *nomScene;
	IBOutlet UILabel *heure;
	IBOutlet UILabel *nomJour;
}

-(void) initWithConcert:(VCConcert*) concert;

@end
