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

#import "CellDetailsDescription.h"


@implementation CellDetailsDescription


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}

-(id) initWithArtiste:(VCArtiste*) artiste
{
	CGSize boundingSize = CGSizeMake(description.frame.size.width, 10000);
	
	CGSize hauteurTexte = [artiste.description sizeWithFont:description.font constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];
	
	description.frame = CGRectMake(description.frame.origin.x, description.frame.origin.y,description.frame.size.width, hauteurTexte.height);
	
	description.text = artiste.description;
	
	return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[description release];
    [super dealloc];
}


@end
