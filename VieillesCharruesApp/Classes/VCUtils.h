//
//  VCListesUtiles.h
//  VieillesCharruesApp
//
//  Created by ToM on 08/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VCUtils : NSObject 
{
}

+(NSDictionary*) getDictionnaireDesJours;
+(NSDictionary*) getDictionnaireDesScenes;
+(void) engregisterImageArtisteSiAbsente:(int)idArtiste urlImage:(NSString*)url;
+(NSString*) determinerHeureDebut:(NSString*) heureDeb heureFin:(NSString*) heureFin;
+(NSString*)getImageArtiste:(NSString*) noArtiste;

@end
