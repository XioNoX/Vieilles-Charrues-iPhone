//
//  CellConcert.m
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CellConcert.h"
#import "VCDataBaseController.h"
#import "VCUtils.h"



@implementation CellConcert

@synthesize heure, groupe,boutonFavori, identifiant, colorView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		
		self.boutonFavori = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 50.0)];
		[boutonFavori setImage:[UIImage imageNamed:@"FavoriUnselected.png"]	forState:UIControlStateNormal];
		[boutonFavori setImage:[UIImage imageNamed:@"FavoriSelected.png"]	forState:UIControlStateSelected];
		[boutonFavori addTarget:self action:@selector(boutonFavoriSelectionne:) forControlEvents:UIControlEventTouchDown];
		[[self contentView] addSubview:boutonFavori];
		
		self.groupe = [[UILabel alloc] initWithFrame:CGRectMake(35.0, 0.0, 180.0, 50.0)];
		[groupe setNumberOfLines:2];
		[groupe setBackgroundColor:[UIColor clearColor]];
		[groupe setMinimumFontSize:11.0];
		[groupe setAdjustsFontSizeToFitWidth:YES];
		[[self contentView] addSubview:groupe];
		[groupe release];

		
		self.heure = [[UILabel alloc] initWithFrame:CGRectMake(212.0, 0.0, 82.0, 50.0)];
		[heure setBackgroundColor:[UIColor clearColor]];
		[heure setTextAlignment:UITextAlignmentRight];
		[heure setFont:[UIFont systemFontOfSize:11.0]];
		[heure setTextColor:[UIColor colorWithRed:48.0/255 green:131/255.0 blue:243.0/255 alpha:1]];
		[[self contentView] addSubview:heure];
		[heure release];
		
		self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)];
		[self setBackgroundView:colorView];
		[colorView release];
    }
    return self;
}

-(void) loadWithConcert :(VCConcert *) nouveauConcert artiste:(NSString *) artiste parity:(BOOL) isOdd {
	
	identifiant = [nouveauConcert.idArtiste intValue];
	
	self.tag = [nouveauConcert.idArtiste intValue];
	self.groupe.text = artiste;
	
	self.heure.text = [VCUtils determinerHeureDebut:nouveauConcert.heureDebut heureFin:nouveauConcert.heureFin];
	
	self.identifiant = [nouveauConcert.idConcert intValue];
	
	if(nouveauConcert.isFavori)
	{
		[boutonFavori setSelected:YES];
	}
	else {
		[boutonFavori setSelected:NO];
	}

	
	if (isOdd)
		[colorView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0.90 alpha:1]];
	else {
		[colorView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
	}
	
	
}

- (void) boutonFavoriSelectionne:(id) sender
{ 
	VCDataBaseController *dataBase = [VCDataBaseController sharedInstance];
	if(((UIButton*)sender).selected)
	{
		[dataBase supprimerConcertDesFavoris:self.identifiant];
		[sender setSelected:NO];
	}
	else
	{
		[dataBase mettreConcertEnFavori:self.identifiant];
		[sender setSelected:YES];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[heure release];
	[groupe release];
	[boutonFavori release];
    [super dealloc];
}


@end
