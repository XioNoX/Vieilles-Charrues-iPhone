//
//  CellTente.m
//
//  Created by ToM on 17/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CellTente.h"

@implementation CellTente

-(void) initWithTente:(VCTente *)tente
{
	boutonSupprimer.tag = tente.identifiant;
	nom.text = tente.nom;
	longitude.text = [NSString stringWithFormat:@"%f", tente.longitude];
	latitude.text = [NSString stringWithFormat:@"%f", tente.latitude];
	
}


@end
