//
//  CellDetailsDescription.h
//  VieillesCharruesApp
//
//  Created by ToM on 08/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCArtiste.h"

@interface CellDetailsDescription : UITableViewCell {
	IBOutlet UILabel *description;
}


-(id) initWithArtiste:(VCArtiste*) artiste;

@end
