//
//  CellConcert.m
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CellConcert.h"
#import "VCDataBaseController.h"


@implementation CellConcert

@synthesize heure, groupe, boutonFavori, identifiant;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (IBAction) boutonFavoriSelectionne
{ 
	VCDataBaseController *dataBase = [VCDataBaseController sharedInstance];
	if(boutonFavori.selected)
	{
		[dataBase supprimerConcertDesFavoris:self.identifiant];
		[boutonFavori setSelected:NO];
	}
	else
	{
		[dataBase mettreConcertEnFavori:self.identifiant];
		[boutonFavori setSelected:YES];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
