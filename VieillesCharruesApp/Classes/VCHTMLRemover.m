//
//  VCHTMLRemover.m
//  VieillesCharruesApp
//
//  Created by ToM on 04/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCHTMLRemover.h"


@implementation VCHTMLRemover

+(void) removeHTMLFromString:(NSMutableString *)HTMLString
{
	NSRange aSupprimer = NSMakeRange(1, 1);
	while (aSupprimer.length != 0) {
		NSRange debutToDel = [HTMLString rangeOfString:@"<"];
		NSRange finToDel = [HTMLString rangeOfString:@">"];
		aSupprimer = NSMakeRange(debutToDel.location, finToDel.location + finToDel.length - debutToDel.location);
		if(aSupprimer.length !=  0)
			[HTMLString replaceCharactersInRange:aSupprimer withString:@""];
	}
}

@end
