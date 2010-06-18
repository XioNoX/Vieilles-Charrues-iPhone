//
//  CellConcert.h
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellConcert : UITableViewCell {
	IBOutlet UILabel *groupe;
	IBOutlet UILabel *heure;
	IBOutlet UIButton *boutonFavori;
	int identifiant;
}

@property (retain, nonatomic) IBOutlet UILabel *groupe;
@property (retain, nonatomic) IBOutlet UILabel *heure;
@property (retain, nonatomic) IBOutlet IBOutlet UIButton *boutonFavori;
@property int identifiant;

-(IBAction) boutonFavoriSelectionne;

@end
