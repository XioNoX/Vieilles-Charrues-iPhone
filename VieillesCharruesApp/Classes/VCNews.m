//
//  VCNews.m
//  VieillesCharruesApp
//
//  Created by ToM on 23/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VCNews.h"
#import "constantes.h"

@implementation VCNews

@synthesize idNews, titre, description, source, date;

-(id)initWithStatement:(sqlite3_stmt*)statement
{
	int news = sqlite3_column_int(statement, 0);
	const char *src = (char*)sqlite3_column_text(statement, 1);
	const char *title = (char*)sqlite3_column_text(statement, 2);
	const char *desc = (char*)sqlite3_column_text(statement, 3);
	const char *dat = (char*)sqlite3_column_text(statement, 4);
	
	
	return [self initWithPrimitives:news titre:title descripion:desc from:src de:dat];
}

-(id)initWithPrimitives:(int)news titre:(const char*)title descripion:(const char*)desc from:(const char*)src de:(const char*)day
{
	NSNumber *idN = [NSNumber numberWithInt:news];
	NSString *t = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
	NSString *d = [NSString stringWithCString:desc encoding:NSUTF8StringEncoding];
	NSString *s = [NSString stringWithCString:src encoding:NSUTF8StringEncoding];
	NSDateFormatter *formateurDeDate = [[NSDateFormatter alloc] init];
	[formateurDeDate setDateFormat:DATEFORMAT];
	[formateurDeDate setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	NSDate *dat = [formateurDeDate dateFromString:[NSString stringWithCString:day encoding:NSUTF8StringEncoding]];
	[formateurDeDate release];
	return [self initWithObjects:idN titre:t descripion:d from:s de:dat];
}

-(id)initWithObjects:(NSNumber *)news titre:(NSString *)title descripion:(NSString *)desc from:(NSString *)src de:(NSDate *)day
{
	idNews = [news retain];
	titre = [title retain];
	description = [desc retain];
	source = [src retain];
	date = [day retain];
		
	return self;
}

@end
