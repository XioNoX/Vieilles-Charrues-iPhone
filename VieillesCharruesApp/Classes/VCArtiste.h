//
//  VCArtiste.h
//  VieillesCharruesApp
//
//  Created by ToM on 29/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface VCArtiste : NSObject 
{
	NSNumber *ident;
	NSString *nom;
	NSString *description;
	NSString *genre;
	NSString *origine;
	NSString *image;
	NSString *lien;
}

@property(retain, nonatomic) NSNumber *ident;
@property(retain, nonatomic) NSString *nom;
@property(retain, nonatomic) NSString *description;
@property(retain, nonatomic) NSString *genre;
@property(retain, nonatomic) NSString *origine;
@property(retain, nonatomic) NSString *image;
@property(retain, nonatomic) NSString *lien;

-(id) initWithSQLStatement:(sqlite3_stmt *)statement;

-(id) initWithId:(NSNumber *)identifiant 
			 nom:(NSString *) name 
	 description:(NSString *) desc 
		   genre:(NSString *)genr 
		venantDe:(NSString *) orig 
		   image:(NSString *) img 
			lien:(NSString *) link; 

@end
