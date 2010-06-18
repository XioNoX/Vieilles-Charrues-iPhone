//
//  VCListesUtiles.m
//  VieillesCharruesApp
//
//  Created by ToM on 08/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCUtils.h"


static NSMutableDictionary *tableauDesJours = nil;
static NSMutableDictionary *dictionnaireDesScenes = nil;

@implementation VCUtils

+(NSDictionary*) getDictionnaireDesJours
{
	if(tableauDesJours == nil)
	{
		tableauDesJours = [[NSMutableDictionary alloc] init];
		[tableauDesJours setObject:@"Jeudi 15 Juillet" forKey:@"1"];
		[tableauDesJours setObject:@"Vendredi 16 Juillet" forKey:@"2"];
		[tableauDesJours setObject:@"Samedi 17 Juillet" forKey:@"3"];
		[tableauDesJours setObject:@"Dimanche 18 Juillet" forKey:@"4"];
		
		
	}
	return tableauDesJours;
	
}

+(void) engregisterImageArtisteSiAbsente:(int)idArtiste urlImage:(NSString*)url
{
	NSData *imageData;
	NSString *nomImageArtiste  = [NSString stringWithFormat:@"Artiste%d.jpg", idArtiste];
	NSString *picturesDirectory = [NSString stringWithFormat:@"%@/ImagesArtistes", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
	NSString *filePath = [NSString stringWithFormat:@"%@/%@",picturesDirectory, nomImageArtiste];
	
	NSFileManager *manager  =[[NSFileManager alloc] init];
	BOOL isDirectory = YES;
	
	if(![manager fileExistsAtPath:picturesDirectory isDirectory:&isDirectory])
	{
		[manager createDirectoryAtPath:picturesDirectory attributes:nil];
	}
	
	//path of the image in the bundle of teh application
	NSString* bundlePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], nomImageArtiste];
	
	//si l'image existe déjà dans le bundle de l'application
	if([manager fileExistsAtPath:bundlePath] )
	{
		//imageData = [NSData dataWithContentsOfFile:filePath];  
		
	}
	//si l'image n'existe pas dans le bundle de l'application : telechargement et enregistrement de l'image en local
	else 
	{
		NSLog(@"%@", filePath);
		imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
		[imageData writeToFile:filePath atomically:YES];
	}
	
	[manager release];
	
}

+(NSString*) getImageArtiste:(NSString *)noArtiste
{
	//path of the image in the "Document" directory
	NSString* documentPath = [NSString stringWithFormat:@"%@/ImagesArtistes/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], noArtiste];
	
	//path of the image in the bundle of teh application
	NSString* bundlePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], noArtiste];
	
	NSFileManager *manager = [[NSFileManager alloc] init];
	if([manager fileExistsAtPath:bundlePath])
	{
		[manager release];
		return bundlePath;
	}
	else {
		[manager release];
		return documentPath;
	}

}

+(NSString*) determinerHeureDebut:(NSString*) heureDeb heureFin:(NSString*) heureFin
{
	
	if(![heureFin isEqualToString:heureDeb])
		return [NSString stringWithFormat:@"%@ - %@", heureDeb, heureFin];
	else 
		return @"indéfini";
}

+(NSDictionary*) getDictionnaireDesScenes
{
	if(dictionnaireDesScenes == nil)
	{
		dictionnaireDesScenes = [[NSMutableDictionary alloc] init];
		[dictionnaireDesScenes setObject:@"Glenmor"  forKey:@"4"];
		[dictionnaireDesScenes setObject:@"Kérouac"  forKey:@"5"];
		[dictionnaireDesScenes setObject:@"X. Grall"  forKey:@"6"];
		[dictionnaireDesScenes setObject:@"Cabaret"  forKey:@"7"];
		[dictionnaireDesScenes setObject:@"Beach Box"  forKey:@"8"];
		[dictionnaireDesScenes setObject:@"Le Verger"  forKey:@"9"];
	}
	
	return dictionnaireDesScenes;
}

@end
