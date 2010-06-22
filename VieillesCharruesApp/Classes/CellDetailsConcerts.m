/*
 * Copyright Thomas Belin 2010
 *
 * This file is part of Vieilles Charrues 2010.
 *
 * Vieilles Charrues 2010 is free software: you can redistribute it
 and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Vieilles Charrues 2010 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Vieilles Charrues 2010.  If not, see
 <http://www.gnu.org/licenses/>.
 */

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
	[nomScene release];
	[heure release];
	[nomJour release];
	
    [super dealloc];
}


@end
