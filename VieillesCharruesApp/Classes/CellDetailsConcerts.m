//
//  CellDetailsConcerts.m
//  VieillesCharruesApp
//
//  Created by ToM on 08/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCUtils.h"
#import "CellDetailsConcerts.h"


@implementation CellDetailsConcerts

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}

-(void) initWithConcert:(VCConcert*) concert
{
	NSDictionary *dictionnaireDesJours = [VCUtils getDictionnaireDesJours];
	NSDictionary *dictionnaireDesScenes = [VCUtils getDictionnaireDesScenes];
	
	
	nomScene.text = [dictionnaireDesScenes objectForKey:[NSString stringWithFormat:@"%i",[concert.idScene intValue]]];
	nomJour.text = [dictionnaireDesJours objectForKey:[NSString stringWithFormat:@"%i", [concert.idJour intValue]]];
	heure.text = [VCUtils determinerHeureDebut:concert.heureDebut heureFin:concert.heureFin];
	
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
