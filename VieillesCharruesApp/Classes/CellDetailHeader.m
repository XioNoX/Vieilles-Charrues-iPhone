//
//  CellDetailHeader.m
//
//  Created by ToM on 08/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CellDetailHeader.h"
#import "VCUtils.h"

@implementation CellDetailHeader

-(void)initWithArtiste:(VCArtiste*)artiste
{
	//verification de l'existance de l'image de l'artiste dans les fichiers locaux, sinon telechargement et enregistrement de l'image	
	NSData *imageData;
	NSString *nomImageArtiste  = [NSString stringWithFormat:@"Artiste%i.jpg", [artiste.ident intValue]];
	//NSString *picturesDirectory = [NSString stringWithFormat:@"%@/ImagesArtistes", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
	//NSString *filePath = [NSString stringWithFormat:@"%@/%@",picturesDirectory, nomImageArtiste];
	

	imageData = [NSData dataWithContentsOfFile:[VCUtils getImageArtiste:nomImageArtiste]];  
	
	[site setFont:[UIFont fontWithName:@"Verdana" size:12]];
	UIImage *imageArtiste = [UIImage imageWithData:imageData];
	
	nomGroupe.text =artiste.nom;
	genre.text = artiste.genre;
	origine.text = artiste.origine;
	site.text = artiste.lien;
	
	[imageGroupe setImage:imageArtiste];
}

@end
