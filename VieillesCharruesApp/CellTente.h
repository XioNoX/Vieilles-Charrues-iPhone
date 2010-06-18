//
//  CellTente.h
//
//  Created by ToM on 17/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "VCTente.h"

@interface CellTente : UITableViewCell {
    IBOutlet UILabel *latitude;
    IBOutlet UILabel *longitude;
    IBOutlet UILabel *nom;
	IBOutlet UIButton *boutonSupprimer;
}

-(void) initWithTente:(VCTente*)tente;

@end
