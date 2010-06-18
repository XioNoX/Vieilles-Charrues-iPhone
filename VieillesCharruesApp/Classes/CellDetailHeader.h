//
//  CellDetailHeader.h
//
//  Created by ToM on 08/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "VCArtiste.h"

@interface CellDetailHeader : UITableViewCell {
    IBOutlet UILabel *genre;
    IBOutlet UIImageView *imageGroupe;
    IBOutlet UILabel *nomGroupe;
    IBOutlet UILabel *origine;
	IBOutlet UITextView *site;
}


-(void)initWithArtiste:(VCArtiste*)artiste;

@end
