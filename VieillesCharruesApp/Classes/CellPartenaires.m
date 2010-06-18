//
//  CellPartenaires.m
//
//  Created by ToM on 05/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CellPartenaires.h"

@implementation CellPartenaires

-(void) initWithNom:(NSString*)name
{
	nom.text = name;
	
	NSString *img = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
	img = [img stringByReplacingOccurrencesOfString:@"." withString:@""];
	img = [img stringByReplacingOccurrencesOfString:@"é" withString:@"e"];
	
	UIImage *imagePart = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", img]];
	if (imagePart == nil) {
		imagePart = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", img]];
	}
	if (imagePart == nil)
		NSLog(@"%@",img);
	[imagePartenaire setImage:imagePart];
}

@end
