//
//  CellDetailsDescription.m
//  VieillesCharruesApp
//
//  Created by ToM on 08/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

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
    [super dealloc];
}


@end
