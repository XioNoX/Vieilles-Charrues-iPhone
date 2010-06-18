//
//  MAJ.h
//  VieillesCharruesApp
//
//  Created by Thomas Belin on 18/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constantes.h"
#import "VCNewsParser.h"

@protocol MAJDelegate <NSObject>

@optional
- (void)majEnded:(NSNumber*)test;

@end


@interface MAJ : NSObject {

	
	
	id<MAJDelegate> delegate;
}

@property (nonatomic, assign) id<MAJDelegate> delegate;

-(void)maj;

@end
