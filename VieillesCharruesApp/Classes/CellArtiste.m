    //
//  CellArtiste.m
//  VieillesCharruesApp
//
//  Created by ToM on 20/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CellArtiste.h"


@implementation CellArtiste

@synthesize groupeLabel;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)CellIdentifier {
	
	[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	self.groupeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 15.0, 250.0, 20.0)];
	[groupeLabel setBackgroundColor:[UIColor clearColor]];
	[groupeLabel setMinimumFontSize:10.0];
	[self addSubview:groupeLabel];
	[groupeLabel release];
	
	
	colorView = [[UIView alloc] initWithFrame:self.frame];
	[self setBackgroundView:colorView];
	[colorView release];
	
	return self;
}

-(void) loadWithArtiste:(NSString*)nomArtiste parity:(BOOL)isOdd {
	
	if (isOdd)
		[colorView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0.90 alpha:1]];
	else {
		[colorView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
	}

	groupeLabel.text = nomArtiste;
}



- (void)dealloc {
	[groupeLabel release];
	[colorView release];
    [super dealloc];
}


@end
