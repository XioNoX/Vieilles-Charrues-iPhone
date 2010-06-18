//
//  VCTente.h
//  VieillesCharruesApp
//
//  Created by ToM on 17/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface VCTente : NSObject {
	int identifiant;
	NSString *nom;
	CGFloat longitude;
	CGFloat latitude;
}

-(id) initWithNom:(NSString*)name longitude:(CGFloat)longi latitude:(CGFloat) lat;

-(id)initWithStatement:(sqlite3_stmt*)statement;

@property (readonly) int identifiant;
@property (retain, nonatomic) NSString* nom;
@property (readonly) CGFloat longitude;
@property (readonly) CGFloat latitude;

@end
