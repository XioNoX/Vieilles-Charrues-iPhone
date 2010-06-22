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

-(void) dealloc {
	[genre release];
	[imageGroupe release];
	[nomGroupe release];
	[origine release];
	[site release];
	
	[super dealloc];
}

@end
