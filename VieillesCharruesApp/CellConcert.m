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

@synthesize heure, groupe, identifiant;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		UIButton	*boutonfavori = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 50.0)];
		[boutonfavori setImage:[UIImage imageNamed:@"FavoriUnselected.png"]	forState:UIControlStateNormal];
		[boutonfavori setImage:[UIImage imageNamed:@"FavoriSelected.png"]	forState:UIControlStateSelected];
		[boutonfavori addTarget:self action:@selector(boutonFavoriSelectionne:) forControlEvents:UIControlEventTouchDown];
		[[self contentView] addSubview:boutonfavori];
		
		self.groupe = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 0.0, 320.0, 20.0)];
		[[self contentView] addSubview:groupe];
		[groupe release];

		
		self.heure = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 20.0)];
		[[self contentView] addSubview:heure];
		[heure release];
    }
    return self;
}

-(void) loadWithConcert :(VCConcert *) nouveauConcert artiste:(NSString *) artiste parity:(BOOL) isOdd{
	
	identifiant = [nouveauConcert.idArtiste intValue];
	
	self.tag = [nouveauConcert.idArtiste intValue];
	self.groupe.text = artiste;
	
	//self.heure.text = [VCUtils determinerHeureDebut:nouveauConcert.heureDebut heureFin:nouveauConcert.heureFin];
	
	self.identifiant = [nouveauConcert.idConcert intValue];
	
	if(nouveauConcert.isFavori)
	{
		
	}
	
	if(isOdd)
	{
		UIView *bg = [[UIView alloc] initWithFrame:self.frame];
		bg.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.90 alpha:1]; // or any color
		self.backgroundView = bg;
		[bg release];
		
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
    [super dealloc];
}


@end
