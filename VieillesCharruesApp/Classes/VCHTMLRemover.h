//
//  VCHTMLRemover.h
//  VieillesCharruesApp
//
//  Created by ToM on 04/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//classe permettant d'enlever toutes les balises HTML d'une chaine de caractères
@interface VCHTMLRemover : NSObject {
	

}

+(void) removeHTMLFromString:(NSString*)HTMLString;

@end
