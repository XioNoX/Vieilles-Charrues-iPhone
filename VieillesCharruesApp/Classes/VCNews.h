//
//  VCNews.h
//  VieillesCharruesApp
//
//  Created by ToM on 23/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface VCNews : NSObject 
{
	NSNumber *idNews;
	NSString *titre;
	NSString *description;
	NSString *source;
	NSDate *date;
}

@property (readonly) NSNumber *idNews;
@property (readonly) NSString *titre;
@property (readonly) NSString *description;
@property (readonly) NSString *source;
@property (readonly) NSDate *date;

-(id)initWithStatement:(sqlite3_stmt*) statement;

-(id)initWithPrimitives:(int)news titre:(const char*)title descripion:(const char*)desc from:(const char*)src de:(const char*)day;

-(id)initWithObjects:(NSNumber*)news 
		  titre:(NSString*) 
title descripion:(NSString*) desc 
		   from:(NSString*)source 
			 de:(NSDate*)day;

@end
